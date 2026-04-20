import 'dart:async';
import 'package:givva_events/data/mock/mock_data.dart';
import 'package:givva_events/data/models/fundraiser.dart';

class FundraiserRepository {
  Future<Map<String, dynamic>> fetchFundraisers({
    required String tab, // 'community' | 'subgroup' | 'archived'
    required int page,   // 0-based
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    final data = {
      'community': [mockCommunityPage1, mockCommunityPage2],
      'subgroup':  [mockSubgroupPage1,  mockSubgroupPage2],
      'archived':  [mockArchivedPage1,  mockArchivedPage2],
    };

    final pagination = {
      'community': [mockCommunityPaginationPage1, mockCommunityPaginationPage2],
      'subgroup':  [mockSubgroupPaginationPage1,  mockSubgroupPaginationPage2],
      'archived':  [mockArchivedPaginationPage1,  mockArchivedPaginationPage2],
    };

    if (!data.containsKey(tab) || page >= data[tab]!.length) {
       // Return empty if out of bounds (or could throw error for testing)
       return {
         "status": 200,
         "message": "ok",
         "result": {
           "data": [],
           "pagination": {
             "page": page,
             "size": 5,
             "totalCount": 0,
             "totalPages": 0,
             "hasNext": false,
             "hasPrevious": page > 0,
           },
           "sorting": null,
         }
       };
    }

    final List<Fundraiser> fundraisers = (data[tab]![page] as List)
        .map((json) => Fundraiser.fromJson(json))
        .toList();
    
    final Pagination paging = Pagination.fromJson(pagination[tab]![page]);

    return {
      "status": 200,
      "message": "ok",
      "result": {
        "data": fundraisers,
        "pagination": paging,
        "sorting": null,
      }
    };
  }
}
