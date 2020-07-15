import 'package:attribute_string/attribute_string.dart';

import 'attribute_string_tree.dart';
import 'attribute_string_tree_paragraph.dart';
import 'attribute_string_tree_root.dart';

class AttributeStringTreeNode extends AttributeStringTree {
  AttributeStringTreeParagraph paragraph;

  AttributeStringTreeNode(AttributeStringTreeParagraph paragraph, String text) {
    this.paragraph = paragraph;
    this.text = text;
  }

  String text;
  Map<String, Attribute> styles = new Map();

  @override
  String toString() {
    return "    Text: '" + this.text + "' Styles: " + this.styles.values.toString();
  }

  /// Split node into two parts.
  void split(int at) {
    if (at == 0 || at == this.text.length) return;

    var newNode = AttributeStringTreeNode(this.paragraph, this.text.substring(0, at));
    newNode.styles = Map.from(this.styles);
    newNode.styles.forEach((key, value) {
      value.end = newNode.text.length;
    });

    this.text = this.text.substring(at, this.text.length);
    this.styles.forEach((key, value) {
      value.end = this.text.length;
    });

    var index = this.paragraph.nodes.indexOf(this);
    this.paragraph.nodes.insert(index, newNode);
  }

  T transform<T>(Transformation<T> transformation) {
    return transformation(this);
  }
}
