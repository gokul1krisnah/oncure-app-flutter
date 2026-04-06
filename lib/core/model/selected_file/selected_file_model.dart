import 'dart:io';

class SelectedFileModel {
  final String? url;
  final File? file;

  SelectedFileModel({this.url, this.file});

  factory SelectedFileModel.image({String? url, File? file}) =>
      SelectedFileModel(
        file: file,
        url: url,
      );
}
