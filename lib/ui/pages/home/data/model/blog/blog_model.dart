
import 'package:freezed_annotation/freezed_annotation.dart';
part 'blog_model.freezed.dart';
part 'blog_model.g.dart';

@freezed
abstract class BlogModel with _$BlogModel {
  const factory BlogModel({
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'body') required String body,
    @JsonKey(name: 'short_description') required String description,
    @JsonKey(name: 'published_date') required String date,
    @JsonKey(name: 'tags') required String tags,
    @JsonKey(name: 'tumor_category') required String category,
    @JsonKey(name: 'blog_image') String? image,
  }) = _BlogModel;

  factory BlogModel.fromJson(Map<String, dynamic> json) => _$BlogModelFromJson(json);
}