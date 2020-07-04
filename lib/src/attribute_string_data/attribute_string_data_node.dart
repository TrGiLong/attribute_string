import '../attribute.dart';
import 'attribute_string_data_paragraph.dart';

class AttributeStringDataNode {
  AttributeStringDataParagraph paragraph;

  AttributeStringDataNode(AttributeStringDataParagraph paragraph, String text) {
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

    var newNode = AttributeStringDataNode(this.paragraph, this.text.substring(0, at));
    newNode.styles = Map.from(this.styles);

    this.text = this.text.substring(at, this.text.length);

    var index = this.paragraph.nodes.indexOf(this);
    this.paragraph.nodes.insert(index, newNode);
  }

}
