import 'package:equatable/equatable.dart';

/// A fundraiser event entity.
class Fundraiser extends Equatable {
  /// Creates a [Fundraiser].
  const Fundraiser({
    required this.id,
    required this.fundraiserTypeName,
    required this.name,
    required this.identifier,
    required this.shortDescription,
    required this.images,
    required this.targetAmount,
    required this.deadline,
    required this.createdAt,
    required this.keyword,
    this.closedAt,
    this.archivedAt,
    this.groupId,
    this.groupName,
  });

  /// Factory for creating a [Fundraiser] from JSON.
  factory Fundraiser.fromJson(Map<String, dynamic> json) {
    return Fundraiser(
      id: json['id'] as String,
      fundraiserTypeName: json['fundraiserTypeName'] as String,
      name: json['name'] as String,
      identifier: json['identifier'] as String,
      shortDescription: json['shortDescription'] as String,
      images: json['images'] as String,
      targetAmount: (json['targetAmount'] as num).toDouble(),
      deadline: DateTime.parse(json['deadline'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      closedAt: json['closedAt'] != null
          ? DateTime.parse(json['closedAt'] as String)
          : null,
      archivedAt: json['archivedAt'] != null
          ? DateTime.parse(json['archivedAt'] as String)
          : null,
      keyword: json['keyword'] as String,
      groupId: json['groupId'] as String?,
      groupName: json['groupName'] as String?,
    );
  }

  /// Unique identifier for the fundraiser.
  final String id;

  /// The type of fundraiser.
  final String fundraiserTypeName;

  /// The display name of the event.
  final String name;

  /// A short identifier (e.g. C101).
  final String identifier;

  /// A brief description of the event.
  final String shortDescription;

  /// URL to the fundraiser image.
  final String images;

  /// The financial goal.
  final double targetAmount;

  /// When the fundraiser ends.
  final DateTime deadline;

  /// When the fundraiser was created.
  final DateTime createdAt;

  /// When the fundraiser was closed, if applicable.
  final DateTime? closedAt;

  /// When the fundraiser was archived, if applicable.
  final DateTime? archivedAt;

  /// Category keyword.
  final String keyword;

  /// Optional group ID.
  final String? groupId;

  /// Optional group name.
  final String? groupName;

  @override
  List<Object?> get props => [
    id,
    fundraiserTypeName,
    name,
    identifier,
    shortDescription,
    images,
    targetAmount,
    deadline,
    createdAt,
    closedAt,
    archivedAt,
    keyword,
    groupId,
    groupName,
  ];
}

/// Pagination metadata.
class Pagination extends Equatable {
  /// Creates a [Pagination].
  const Pagination({
    required this.page,
    required this.size,
    required this.totalCount,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
  });

  /// Factory for creating [Pagination] from JSON.
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] as int,
      size: json['size'] as int,
      totalCount: json['totalCount'] as int,
      totalPages: json['totalPages'] as int,
      hasNext: json['hasNext'] as bool,
      hasPrevious: json['hasPrevious'] as bool,
    );
  }

  /// Current page index (0-based).
  final int page;

  /// Number of items per page.
  final int size;

  /// Total number of items across all pages.
  final int totalCount;

  /// Total number of pages available.
  final int totalPages;

  /// Whether there is a next page.
  final bool hasNext;

  /// Whether there is a previous page.
  final bool hasPrevious;

  @override
  List<Object?> get props => [
    page,
    size,
    totalCount,
    totalPages,
    hasNext,
    hasPrevious,
  ];
}
