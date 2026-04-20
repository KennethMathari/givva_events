import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givva_events/data/repositories/fundraiser_repository.dart';
import 'package:givva_events/logic/bloc/fundraiser_bloc.dart';
import 'package:givva_events/presentation/screens/events_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FundraiserRepository(),
      child: BlocProvider(
        create: (context) => FundraiserBloc(
          repository: context.read<FundraiserRepository>(),
        ),
        child: MaterialApp(
          title: 'Givva Events',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            useMaterial3: true,
            fontFamily: 'Roboto',
          ),
          home: const EventsScreen(),
        ),
      ),
    );
  }
}
