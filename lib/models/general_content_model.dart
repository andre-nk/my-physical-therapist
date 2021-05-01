part of "model.dart";

class GeneralContentModel {
  String text;
  String? imageURL;

  GeneralContentModel({required this.text, this.imageURL}) {
    this.text = text;
    this.imageURL = imageURL ?? "";
  }
}
