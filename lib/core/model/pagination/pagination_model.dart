class PaginationModel<T> {
  final List<T> items;
  final String? nextCursor;

  PaginationModel({
    required this.items,
    this.nextCursor,
  });

  factory PaginationModel.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      PaginationModel<T>(
        items: (json['items'] as List).map((itemJson) => fromJsonT(itemJson)).toList(),
        nextCursor: json['nextCursor'] != null ? json['nextCursor'] as String : null,
      );
}
