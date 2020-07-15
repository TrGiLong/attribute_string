import '../attribute.dart';
import 'attribute_string_tree.dart';
import 'attribute_string_tree_node.dart';
import 'attribute_string_tree_root.dart';

class AttributeStringTreeParagraph extends AttributeStringTree {
  AttributeStringTreeRoot root;
  int length;
  List<AttributeStringTreeNode> nodes = [];

  AttributeStringTreeParagraph(AttributeStringTreeRoot root, String text) {
    length = text.length;
    nodes.add(AttributeStringTreeNode(this, text));
  }

  @override
  String toString() {
    return "  Paragraph \n" + nodes.join('\n');
  }

  void apply(String key, String value, int start, int end) {
    var count = 0;

    // Split character at start
    AttributeStringTreeNode startNode;
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
    AttributeStringTreeNode endNode;
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

  T transform<T>(Transformation<T> transformation) {
    return transformation(this);
  }
}
