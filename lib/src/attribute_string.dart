import 'package:basic_utils/basic_utils.dart';
import 'package:rich_text_editor/src/attribute.dart';

class AttributeString {
  static const String Bold = "bold";
  static const String Italic = "italic";
  static const String Underline = "underline";
  static const String Size = "size";
  static const String Font = "font";

  String text;
  List<Attribute> attributes;

  AttributeString({this.text = ""}) {
    attributes = [];
  }

  void insert(String otherText, int at) {
    text = StringUtils.addCharAtPosition(this.text, otherText, at);
    for (var attribute in attributes) {
      if (attribute.containIndex(at)) {

      }
    }
  }

  void append(String text) {
    this.insert(text, text.length);
  }

  void apply(String key, String value, int start, int end) {
    attributes.add(Attribute(key, value, start, end));
  }
}
