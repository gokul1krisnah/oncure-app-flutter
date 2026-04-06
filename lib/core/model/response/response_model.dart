class ResponseModel<T> {
  final int? status;
  final String? message;
  final T data;

  ResponseModel({
    required this.data, this.status,
    this.message,
  });

  factory ResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      ResponseModel(
        status: json['status'] as int,
        message: json['message'],
        data: fromJsonT(json['data']),
      );
}
