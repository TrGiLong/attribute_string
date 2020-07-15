import 'package:flutter/material.dart';
import 'package:attribute_string/attribute_string.dart';

extension AttributeStringToJsonTree on AttributeString {
  String toJsonTree({TextStyle baseStyle}) {
    AttributeStringTreeRoot root = AttributeStringTreeRoot(this.text);
    for (var style in this.attributes) {
      root.apply(style);
    }
    return root.build(baseStyle: baseStyle);
  }
}

extension _AttributeStringRootBuilder on AttributeStringTreeRoot {
  String build({TextStyle baseStyle}) {
    return '{"root":[${this.paragraphs.map((paragraph) => paragraph.build(baseStyle: baseStyle)).join(",")}]}';
  }
}

extension _AttributeStringParagraphBuilder on AttributeStringTreeParagraph {
  String build({TextStyle baseStyle}) {
    return '{"textSpan":[${this.nodes.map((node) => node.build(baseStyle: baseStyle)).join(",")}]}';
  }
}

extension _AttributeStringNodeBuilder on AttributeStringTreeNode {
  String build({TextStyle baseStyle}) {
    return '{"text":"${this.text}", "styles":[${this.styles.values.map((attribute) => '{"key":"${attribute.key}","value":${extractValue(attribute.value)}}').join(",")}]}';
  }

  String extractValue(String value) {
    if (value == null) {
      return '""';
    }
    return '"$value"';
  }
}
