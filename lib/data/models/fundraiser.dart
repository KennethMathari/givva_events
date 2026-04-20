import 'package:equatable/equatable.dart';

class Fundraiser extends Equatable {
  final String id;
  final String fundraiserTypeName;
  final String name;
  final String identifier;
  final String shortDescription;
  final String images;
  final double targetAmount;
  final DateTime deadline;
  final DateTime createdAt;
  final DateTime? closedAt;
  final DateTime? archivedAt;
  final String keyword;
  final String? groupId;
  final String? groupName;

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
    this.closedAt,
    this.archivedAt,
    required this.keyword,
    this.groupId,
    this.groupName,
  });

  factory Fundraiser.fromJson(Map<String, dynamic> json) {
    return Fundraiser(
      id: json['id'],
      fundraiserTypeName: json['fundraiserTypeName'],
      name: json['name'],
      identifier: json['identifier'],
      shortDescription: json['shortDescription'],
      images: json['images'],
      targetAmount: (json['targetAmount'] as num).toDouble(),
      deadline: DateTime.parse(json['deadline']),
      createdAt: DateTime.parse(json['createdAt']),
      closedAt: json['closedAt'] != null ? DateTime.parse(json['closedAt']) : null,
      archivedAt: json['archivedAt'] != null ? DateTime.parse(json['archivedAt']) : null,
      keyword: json['keyword'],
      groupId: json['groupId'],
      groupName: json['groupName'],
    );
  }

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

class Pagination extends Equatable {
  final int page;
  final int size;
  final int totalCount;
  final int totalPages;
  final bool hasNext;
  final bool hasPrevious;

  const Pagination({
    required this.page,
    required this.size,
    required this.totalCount,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      size: json['size'],
      totalCount: json['totalCount'],
      totalPages: json['totalPages'],
      hasNext: json['hasNext'],
      hasPrevious: json['hasPrevious'],
    );
  }

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
