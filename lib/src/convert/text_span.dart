import 'package:flutter/material.dart';
import 'package:attribute_string/attribute_string.dart';
import 'package:attribute_string/src/attribute.dart';
import 'package:attribute_string/src/attribute_string_tree/attribute_string_tree_node.dart';
import 'package:attribute_string/src/attribute_string_tree/attribute_string_tree_paragraph.dart';
import 'package:attribute_string/src/attribute_string_tree/attribute_string_tree_root.dart';

extension AttributeStringToTextSpan on AttributeString {
  TextSpan toTextSpan({TextStyle baseStyle}) {
    AttributeStringTreeRoot root = AttributeStringTreeRoot(this.text);
    for (var style in this.attributes) {
      root.apply(style);
    }
    return root.build(baseStyle: baseStyle);
  }
}

extension _AttributeStringRootBuilder on AttributeStringTreeRoot {
  TextSpan build({TextStyle baseStyle}) {
    return TextSpan(children: this.paragraphs.map((p) => p.build(baseStyle: baseStyle)).toList(growable: false));
  }
}

extension _AttributeStringParagraphBuilder on AttributeStringTreeParagraph {
  TextSpan build({TextStyle baseStyle}) {
    return TextSpan(children: this.nodes.map((node) => node.build(baseStyle: baseStyle)).toList(growable: false));
  }
}

typedef StyleBuilder(value);

Map<String, StyleBuilder> _styles = {
  Attribute.Bold: (value) => TextStyle(fontWeight: FontWeight.bold),
  Attribute.Italic: (value) => TextStyle(fontStyle: FontStyle.italic),
  Attribute.Underline: (value) => TextStyle(decoration: TextDecoration.underline),
  Attribute.Size: (value) => TextStyle(fontSize: value),
  Attribute.Font: (value) => TextStyle(fontFamily: value),
  Attribute.Link: (value) => TextStyle(color: Colors.blue),
  Attribute.Color: (value) => TextStyle(color: value),
  Attribute.Strikethrough: (value) => TextStyle(decoration: TextDecoration.lineThrough),
};

extension _AttributeStringNodeBuilder on AttributeStringTreeNode {
  TextSpan build({TextStyle baseStyle}) {
    var styles = this.styles.values.map((style) => _styles[style.key](style.value));

    var mergedStyle = baseStyle ?? TextStyle(color: Colors.black);
    for (var style in styles) {
      mergedStyle = mergedStyle.merge(style);
    }

    if (this.styles.keys.contains(Attribute.Strikethrough) && this.styles.keys.contains(Attribute.Underline)) {
      // Special case
      mergedStyle = mergedStyle
          .merge(TextStyle(decoration: TextDecoration.combine([TextDecoration.lineThrough, TextDecoration.underline])));
    }

    return TextSpan(text: this.text, style: mergedStyle);
  }
}
