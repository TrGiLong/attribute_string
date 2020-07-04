import '../attribute.dart';
import 'attribute_string_data_node.dart';
import 'attribute_string_data_root.dart';

class AttributeStringDataParagraph {
  AttributeStringDataRoot root;
  int length;
  List<AttributeStringDataNode> nodes = [];

  AttributeStringDataParagraph(AttributeStringDataRoot root, String text) {
    length = text.length;
    nodes.add(AttributeStringDataNode(this, text));
  }

  @override
  String toString() {
    return "  Paragraph \n" + nodes.join('\n');
  }

  void apply(String key, String value, int start, int end) {
    var count = 0;

    // Split character at start
    AttributeStringDataNode startNode;
    for (var node in this.nodes) {
      if (start < count + node.text.length) {
        startNode = node;
        break;
      }
      count += node.text.length;
    }
    if (startNode != null) {
      startNode.split(start - count);
    }

    // Split character at end
    count = 0;
    AttributeStringDataNode endNode;
    for (var node in this.nodes) {
      if (count + node.text.length < end) {
      } else {
        endNode = node;
        break;
      }
      count += node.text.length;
    }
    if (endNode != null) {
      endNode.split(end - count);
    }

    // Apply attribute to node.
    count = 0;
    for (var node in this.nodes) {
      if (start < (count + node.text.length) && count < end) {
        node.styles[key] = Attribute(key, value, 0, node.text.length - 1);
      }
      count += node.text.length;
    }
  }
}
