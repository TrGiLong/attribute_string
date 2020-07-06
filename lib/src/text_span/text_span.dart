import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rich_text_editor/rich_text_editor.dart';
import 'package:rich_text_editor/src/attribute.dart';
import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data_node.dart';
import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data_paragraph.dart';
import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data_root.dart';

extension RichTextTextSpanBuilder on AttributeString {
  TextSpan toTextSpan({TextStyle baseStyle}) {
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
  Attribute.Bold: (value) => TextStyle(fontWeight: FontWeight.bold),
  Attribute.Italic: (value) => TextStyle(fontStyle: FontStyle.italic),
  Attribute.Underline: (value) => TextStyle(decoration: TextDecoration.underline),
  Attribute.Size: (value) => TextStyle(fontSize: value),
  Attribute.Font: (value) => TextStyle(fontFamily: value),
  Attribute.Link: (value) => TextStyle(),
};

extension _AttributeStringNodeBuilder on AttributeStringDataNode {
  TextSpan build({TextStyle baseStyle}) {
    var styles = this.styles.values.map((style) => _styles[style.key](style.value));

    var mergedStyle = baseStyle ?? TextStyle(color: Colors.black);
    for (var style in styles) {
      mergedStyle = mergedStyle.merge(style);
    }

    return TextSpan(
        text: this.text,
        style: mergedStyle,
        recognizer: _styles.containsKey(Attribute.Link) ? TapGestureRecognizer() : null);
  }
}
