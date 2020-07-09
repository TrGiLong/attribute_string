//import 'package:flutter/material.dart';
//import 'package:rich_text_editor/rich_text_editor.dart';
//import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data_node.dart';
//import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data_paragraph.dart';
//import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data_root.dart';
//
//extension AttributeStringToJsonTree on AttributeString {
//  String toJsonTree({TextStyle baseStyle}) {
//    AttributeStringDataRoot root = AttributeStringDataRoot(this.text);
//    for (var style in this.attributes) {
//      root.apply(style);
//    }
//    return root.build(baseStyle: baseStyle);
//  }
//}
//
//extension _AttributeStringRootBuilder on AttributeStringDataRoot {
//  String build({TextStyle baseStyle}) {
//    return '{"root":[${this.paragraphs.map((paragraph) => paragraph.build(baseStyle: baseStyle)).join(",")}]}';
//  }
//}
//
//extension _AttributeStringParagraphBuilder on AttributeStringDataParagraph {
//  String build({TextStyle baseStyle}) {
//    return '{"textSpan":[${this.nodes.map((node) => node.build(baseStyle: baseStyle)).join(",")}]}';
//  }
//}
//
//extension _AttributeStringNodeBuilder on AttributeStringDataNode {
//  String build({TextStyle baseStyle}) {
//    return '{"text":"${this.text}", "styles":[${this.styles.values.map((attribute) => '{"key":"${attribute.key}","value":${extractValue(attribute.value)}}').join(",")}]}';
//  }
//
//  String extractValue(String value) {
//    if (value == null) {
//      return '""';
//    }
//    return '"$value"';
//  }
//}
