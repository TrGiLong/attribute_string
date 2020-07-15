import 'package:flutter/cupertino.dart';
import 'package:attribute_string/attribute_string.dart';
import 'package:attribute_string/src/attribute_string.dart';
import 'package:attribute_string/src/attribute_string_tree/attribute_string_tree_paragraph.dart';
import 'package:attribute_string/src/attribute_string_tree/attribute_string_tree_root.dart';

extension AttributeStringToHtml on AttributeString {
  String toHtml() {
    AttributeStringTreeRoot root = AttributeStringTreeRoot(this.text);
    for (var style in this.attributes) {
      root.apply(style);
    }
    return root.build();
  }
}

extension _AttributeStringRootBuilder on AttributeStringTreeRoot {
  String build() {
    return this.paragraphs.map((e) => e.build()).join("");
  }
}

extension _AttributeStringParagraphBuilder on AttributeStringTreeParagraph {
  String build() {
    return "<p>${this.nodes.map((e) => e.build()).join("")}</p>";
  }
}

typedef TagBuilder = String Function(String text, dynamic value);

Map<String, TagBuilder> _tagsBuilder = {
  Attribute.Bold: (text, value) => "<b>$text</b>",
  Attribute.Italic: (text, value) => "<i>$text</i>",
  Attribute.Link: (text, value) => "<a href='$value'>$text</a>",
  Attribute.Size: (text, value) => "<span style='font-size:${value}pt'>$text</span>",
  Attribute.Font: (text, value) => '<span style="font-family:$value">$text</span>',
  Attribute.Color: (text, value) => '<span style="color:${(value as Color).value}">$text</span>',
  Attribute.Underline: (text, value) => '<span style="text-decoration:underline">$text</span>',
  Attribute.Strikethrough: (text, value) => '<span style="text-decoration:line-through">$text</span>',
};

extension _AttributeStringNodeBuilder on AttributeStringTreeNode {
  String build() {
    String builder = this.text.replaceAll('\n', '');

    for (var attribute in this.styles.values) {
      builder = _tagsBuilder[attribute.key](builder, attribute.value);
    }

    return builder;
  }
}
