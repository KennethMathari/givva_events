import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givva_events/data/models/fundraiser.dart';
import 'package:givva_events/data/repositories/fundraiser_repository.dart';

// EVENTS
abstract class FundraiserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchFundraisers extends FundraiserEvent {
  final String tab;
  final int page;

  FetchFundraisers({required this.tab, this.page = 0});

  @override
  List<Object?> get props => [tab, page];
}

// STATE
class FundraiserState extends Equatable {
  final Map<String, List<Fundraiser>> data;
  final Map<String, Pagination?> pagination;
  final Map<String, bool> isLoading;
  final Map<String, String?> errors;

  const FundraiserState({
    required this.data,
    required this.pagination,
    required this.isLoading,
    required this.errors,
  });

  factory FundraiserState.initial() {
    return const FundraiserState(
      data: {'community': [], 'subgroup': [], 'archived': []},
      pagination: {'community': null, 'subgroup': null, 'archived': null},
      isLoading: {'community': false, 'subgroup': false, 'archived': false},
      errors: {'community': null, 'subgroup': null, 'archived': null},
    );
  }

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

// BLOC
class FundraiserBloc extends Bloc<FundraiserEvent, FundraiserState> {
  final FundraiserRepository repository;

  FundraiserBloc({required this.repository}) : super(FundraiserState.initial()) {
    on<FetchFundraisers>(_onFetchFundraisers);
  }

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
      final response = await repository.fetchFundraisers(tab: tab, page: event.page);
      
      if (response['status'] == 200) {
        final List<Fundraiser> newData = response['result']['data'];
        final Pagination newPaging = response['result']['pagination'];

        final updatedData = Map<String, List<Fundraiser>>.from(state.data)..[tab] = newData;
        final updatedPagination = Map<String, Pagination?>.from(state.pagination)..[tab] = newPaging;
        final updatedLoading = Map<String, bool>.from(state.isLoading)..[tab] = false;

        emit(state.copyWith(
          data: updatedData,
          pagination: updatedPagination,
          isLoading: updatedLoading,
        ));
      } else {
        throw Exception(response['message'] ?? 'Failed to fetch fundraisers');
      }
    } catch (e) {
      final updatedLoading = Map<String, bool>.from(state.isLoading)..[tab] = false;
      final updatedErrors = Map<String, String?>.from(state.errors)..[tab] = e.toString();
      emit(state.copyWith(isLoading: updatedLoading, errors: updatedErrors));
    }
  }
}
