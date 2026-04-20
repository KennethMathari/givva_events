import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givva_events/logic/bloc/fundraiser_bloc.dart';
import 'package:givva_events/presentation/widgets/fundraiser_card.dart';
import 'package:givva_events/presentation/widgets/pagination_controls.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final List<String> tabs = ['community', 'subgroup', 'archived'];
  final Map<String, String> tabLabels = {
    'community': 'Community Events',
    'subgroup': 'Subgroup Events',
    'archived': 'Archived Events',
  };

  @override
  void initState() {
    super.initState();
    // Initial fetch for all tabs or just the first one?
    // Requirement says "restore that tab's last pagination state".
    // Let's fetch the first page for all tabs to ensure data is ready.
    for (var tab in tabs) {
      context.read<FundraiserBloc>().add(FetchFundraisers(tab: tab, page: 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF9C4), Color(0xFFF8BBD0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {},
            ),
            title: const Text(
              'Fund Collection Events',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey[600],
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                  indicator: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.orange.withOpacity(0.3)),
                  ),
                  tabs: tabs.map((tab) => Tab(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tabLabels[tab]!,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: tabs.map((tab) => _buildTabContent(tab)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(String tab) {
    return BlocBuilder<FundraiserBloc, FundraiserState>(
      builder: (context, state) {
        final isLoading = state.isLoading[tab] ?? false;
        final error = state.errors[tab];
        final fundraisers = state.data[tab] ?? [];
        final pagination = state.pagination[tab];

        if (isLoading && fundraisers.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (error != null && fundraisers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: $error', style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<FundraiserBloc>().add(
                          FetchFundraisers(tab: tab, page: pagination?.page ?? 0),
                        );
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<FundraiserBloc>().add(FetchFundraisers(tab: tab, page: 0));
                  },
                  child: Stack(
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: fundraisers.length,
                        itemBuilder: (context, index) {
                          return FundraiserCard(fundraiser: fundraisers[index]);
                        },
                      ),
                      if (isLoading)
                        const Positioned(
                          top: 20,
                          left: 0,
                          right: 0,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  ),
                ),
              ),
              if (pagination != null)
                PaginationControls(
                  pagination: pagination,
                  onPageChanged: (newPage) {
                    context.read<FundraiserBloc>().add(
                      FetchFundraisers(tab: tab, page: newPage),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
