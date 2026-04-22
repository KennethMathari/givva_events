import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givva_events/data/models/fundraiser.dart';
import 'package:givva_events/data/repositories/fundraiser_repository.dart';

/// Base class for all fundraiser events.
abstract class FundraiserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event to fetch fundraisers for a specific tab and page.
class FetchFundraisers extends FundraiserEvent {
  /// Creates a [FetchFundraisers] event.
  FetchFundraisers({required this.tab, this.page = 0});

  /// The tab to fetch fundraisers for.
  final String tab;

  /// The page number to fetch.
  final int page;

  @override
  List<Object?> get props => [tab, page];
}

/// State of the fundraiser feature.
class FundraiserState extends Equatable {
  /// Creates a [FundraiserState].
  const FundraiserState({
    required this.data,
    required this.pagination,
    required this.isLoading,
    required this.errors,
  });

  /// Initial state for the fundraiser feature.
  factory FundraiserState.initial() {
    return const FundraiserState(
      data: {'community': [], 'subgroup': [], 'archived': []},
      pagination: {'community': null, 'subgroup': null, 'archived': null},
      isLoading: {'community': false, 'subgroup': false, 'archived': false},
      errors: {'community': null, 'subgroup': null, 'archived': null},
    );
  }

  /// Data for each tab.
  final Map<String, List<Fundraiser>> data;

  /// Pagination info for each tab.
  final Map<String, Pagination?> pagination;

  /// Loading status for each tab.
  final Map<String, bool> isLoading;

  /// Errors for each tab.
  final Map<String, String?> errors;

  /// Creates a copy of this state with the given fields replaced.
  FundraiserState copyWith({
    Map<String, List<Fundraiser>>? data,
    Map<String, Pagination?>? pagination,
    Map<String, bool>? isLoading,
    Map<String, String?>? errors,
  }) {
    return FundraiserState(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
      isLoading: isLoading ?? this.isLoading,
      errors: errors ?? this.errors,
    );
  }

  @override
  List<Object?> get props => [data, pagination, isLoading, errors];
}

/// BLoC for managing fundraiser data.
class FundraiserBloc extends Bloc<FundraiserEvent, FundraiserState> {
  /// Creates a [FundraiserBloc].
  FundraiserBloc({required this.repository})
    : super(FundraiserState.initial()) {
    on<FetchFundraisers>(_onFetchFundraisers);
  }

  /// The repository used to fetch fundraiser data.
  final FundraiserRepository repository;

  Future<void> _onFetchFundraisers(
    FetchFundraisers event,
    Emitter<FundraiserState> emit,
  ) async {
    final tab = event.tab;

    // Set loading for specific tab
    final newLoading = Map<String, bool>.from(state.isLoading)..[tab] = true;
    final newErrors = Map<String, String?>.from(state.errors)..[tab] = null;
    emit(state.copyWith(isLoading: newLoading, errors: newErrors));

    try {
      final response = await repository.fetchFundraisers(
        tab: tab,
        page: event.page,
      );

      if (response['status'] == 200) {
        final result = response['result'] as Map<String, dynamic>;
        final newData = result['data'] as List<Fundraiser>;
        final newPaging = result['pagination'] as Pagination;

        final updatedData = Map<String, List<Fundraiser>>.from(state.data)
          ..[tab] = newData;
        final updatedPagination = Map<String, Pagination?>.from(
          state.pagination,
        )..[tab] = newPaging;
        final updatedLoading = Map<String, bool>.from(state.isLoading)
          ..[tab] = false;

        emit(
          state.copyWith(
            data: updatedData,
            pagination: updatedPagination,
            isLoading: updatedLoading,
          ),
        );
      } else {
        throw Exception(response['message'] ?? 'Failed to fetch fundraisers');
      }
    } catch (e) {
      final updatedLoading = Map<String, bool>.from(state.isLoading)
        ..[tab] = false;
      final updatedErrors = Map<String, String?>.from(state.errors)
        ..[tab] = e.toString();
      emit(state.copyWith(isLoading: updatedLoading, errors: updatedErrors));
    }
  }
}
