import 'package:attribute_string/attribute_string.dart';

import '../attribute.dart';
import 'attribute_string_tree.dart';
import 'attribute_string_tree_paragraph.dart';

typedef Transformation<T> = T Function(AttributeStringTree attributeStringData);

class AttributeStringTreeRoot extends AttributeStringTree {
  List<AttributeStringTreeParagraph> paragraphs = [];


  
  factory AttributeStringTreeRoot.from(AttributeString attributeString) {
    var root = AttributeStringTreeRoot(attributeString.text);
    
    for (var attribute in attributeString.attributes) {
      root.apply(attribute);
    }
    
    return root;
  }

  AttributeStringTreeRoot(String text) {
    if (text.length == 0) {
      return;
    }

    List<String> split = text.split('\n');
    for (int x = 0; x < split.length; x++) {
      var substring = split[x];
      if (x < split.length - 1)
        substring += '\n';

      paragraphs.add(AttributeStringTreeParagraph(this, substring));
    }
  }

  @override
  String toString() {
    return "Root \n" + paragraphs.join("\n");
  }

  void apply(Attribute attribute) {
    var count = 0;
    for (var paragraph in this.paragraphs) {
      if (attribute.start < (count + paragraph.length) && count < attribute.end) {
        var start = attribute.start - count;
        if (start < 0) {
          start = 0;
        }
        var end = attribute.end - count;
        if (end > paragraph.length) {
          end = paragraph.length;
        }

        paragraph.apply(attribute.key, attribute.value, start, end);
      }

      count += paragraph.length;
    }
  }

  T transform<T>(Transformation<T> transformation) {
    return transformation(this);
  }
}
