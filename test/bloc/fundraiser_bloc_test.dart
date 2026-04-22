import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:givva_events/data/models/fundraiser.dart';
import 'package:givva_events/data/repositories/fundraiser_repository.dart';
import 'package:givva_events/logic/bloc/fundraiser_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockFundraiserRepository extends Mock implements FundraiserRepository {}

void main() {
  late FundraiserRepository repository;
  late FundraiserBloc bloc;

  setUp(() {
    repository = MockFundraiserRepository();
    bloc = FundraiserBloc(repository: repository);
  });

  tearDown(() {
    bloc.close();
  });

  group('FundraiserBloc', () {
    final mockFundraiser = Fundraiser(
      id: '1',
      fundraiserTypeName: 'Test Type',
      name: 'Test Event',
      identifier: 'C101',
      shortDescription: 'Desc',
      images: 'https://img.com',
      targetAmount: 100,
      deadline: DateTime.now(),
      createdAt: DateTime.now(),
      keyword: 'TEST',
    );

    final mockPagination = const Pagination(
      page: 0,
      size: 5,
      totalCount: 1,
      totalPages: 1,
      hasNext: false,
      hasPrevious: false,
    );

    blocTest<FundraiserBloc, FundraiserState>(
      'emits [loading, success] when FetchFundraisers is added',
      build: () {
        when(
          () => repository.fetchFundraisers(tab: 'community', page: 0),
        ).thenAnswer(
          (_) async => {
            'status': 200,
            'result': {
              'data': [mockFundraiser],
              'pagination': mockPagination,
            },
          },
        );
        return bloc;
      },
      act: (bloc) => bloc.add(FetchFundraisers(tab: 'community', page: 0)),
      expect: () => [
        // Loading state
        isA<FundraiserState>().having(
          (s) => s.isLoading['community'],
          'isLoading community',
          true,
        ),
        // Success state
        isA<FundraiserState>()
            .having((s) => s.isLoading['community'], 'isLoading', false)
            .having((s) => s.data['community'], 'data', [mockFundraiser])
            .having(
              (s) => s.pagination['community'],
              'pagination',
              mockPagination,
            ),
      ],
    );

    blocTest<FundraiserBloc, FundraiserState>(
      'emits [loading, error] when repository throws exception',
      build: () {
        when(
          () => repository.fetchFundraisers(tab: 'community', page: 0),
        ).thenThrow(Exception('Failed to fetch'));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchFundraisers(tab: 'community', page: 0)),
      expect: () => [
        isA<FundraiserState>().having(
          (s) => s.isLoading['community'],
          'isLoading',
          true,
        ),
        isA<FundraiserState>()
            .having((s) => s.isLoading['community'], 'isLoading', false)
            .having(
              (s) => s.errors['community'],
              'error',
              contains('Exception: Failed to fetch'),
            ),
      ],
    );
  });
}
