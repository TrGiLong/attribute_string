import 'package:flutter/material.dart';
import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data_node.dart';
import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data_paragraph.dart';
import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data_root.dart';

import '../attribute_string.dart';

extension RichTextTextSpanBuilder on AttributeString {
  TextSpan build({TextStyle baseStyle}) {
    AttributeStringDataRoot root = AttributeStringDataRoot(this.text);
    for (var style in this.attributes) {
      root.apply(style);
    }
    return root.build(baseStyle: baseStyle);
  }
}

extension _AttributeStringRootBuilder on AttributeStringDataRoot {
  TextSpan build({TextStyle baseStyle}) {
    return TextSpan(children: this.paragraphs.map((p) => p.build(baseStyle: baseStyle)).toList(growable: false));
  }
}

extension _AttributeStringParagraphBuilder on AttributeStringDataParagraph {
  TextSpan build({TextStyle baseStyle}) {
    return TextSpan(children: this.nodes.map((node) => node.build(baseStyle: baseStyle)).toList(growable: false));
  }
}

typedef StyleBuilder(value);

Map<String, StyleBuilder> _styles = {
  AttributeString.Bold: (value) => TextStyle(fontWeight: FontWeight.bold),
  AttributeString.Italic: (value) => TextStyle(fontStyle: FontStyle.italic),
  AttributeString.Underline: (value) => TextStyle(decoration: TextDecoration.underline),
  AttributeString.Size: (value) => TextStyle(fontSize: value),
  AttributeString.Font: (value) => TextStyle(fontFamily: value),
};

extension _AttributeStringNodeBuilder on AttributeStringDataNode {
  TextSpan build({TextStyle baseStyle}) {
    var styles = this.styles.values.map((style) => _styles[style.key](style.value));

    var mergedStyle = baseStyle ?? TextStyle(color: Colors.black);
    for (var style in styles) {
      mergedStyle = mergedStyle.merge(style);
    }

    return TextSpan(text: this.text, style: mergedStyle);
  }
}
