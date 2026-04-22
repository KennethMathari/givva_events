import 'dart:async';
import 'package:givva_events/data/mock/mock_data.dart';
import 'package:givva_events/data/models/fundraiser.dart';

/// Repository for fetching fundraiser data.
class FundraiserRepository {
  /// Fetches a paginated list of fundraisers for a given tab.
  Future<Map<String, dynamic>> fetchFundraisers({
    required String tab, // 'community' | 'subgroup' | 'archived'
    required int page, // 0-based
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    final data = {
      'community': [mockCommunityPage1, mockCommunityPage2],
      'subgroup': [mockSubgroupPage1, mockSubgroupPage2],
      'archived': [mockArchivedPage1, mockArchivedPage2],
    };

    final pagination = {
      'community': [mockCommunityPaginationPage1, mockCommunityPaginationPage2],
      'subgroup': [mockSubgroupPaginationPage1, mockSubgroupPaginationPage2],
      'archived': [mockArchivedPaginationPage1, mockArchivedPaginationPage2],
    };

    if (!data.containsKey(tab) || page >= (data[tab]?.length ?? 0)) {
      // Return empty if out of bounds (or could throw error for testing)
      return {
        'status': 200,
        'message': 'ok',
        'result': {
          'data': <Fundraiser>[],
          'pagination': Pagination(
            page: page,
            size: 5,
            totalCount: 0,
            totalPages: 0,
            hasNext: false,
            hasPrevious: page > 0,
          ),
          'sorting': null,
        },
      };
    }

    final List<Fundraiser> fundraisers =
        (data[tab]![page] as List<Map<String, dynamic>>)
            .map((json) => Fundraiser.fromJson(json))
            .toList();

    final Pagination paging = Pagination.fromJson(
      pagination[tab]![page] as Map<String, dynamic>,
    );

    return {
      'status': 200,
      'message': 'ok',
      'result': {
        'data': fundraisers,
        'pagination': paging,
        'sorting': null,
      },
    };
  }
}
