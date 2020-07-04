//import 'dart:ui';
//
//import 'package:flutter/widgets.dart';
//import 'package:rich_text_editor/src/attribute_string.dart';
//import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data_node.dart';
//import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data_paragraph.dart';
//import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data_root.dart';
//
//import 'builder.dart' as _;
//
//typedef StyleBuilder(value);
//
//Map<String, StyleBuilder> _styles = {
//  AttributeString.Bold: (value) => TextStyle(fontWeight: FontWeight.bold),
//  AttributeString.Italic: (value) => TextStyle(fontStyle: FontStyle.italic),
//  AttributeString.Underline: (value) => TextStyle(decoration: TextDecoration.underline),
//  AttributeString.Size: (value) => TextStyle(fontSize: value),
//  AttributeString.Font: (value) => TextStyle(fontFamily: value),
//};
//
//extension TextSpanBuilder on AttributeString {
//  TextSpan toTextSpan({TextStyle baseStyle}) {
//    AttributeStringDataRoot root = AttributeStringDataRoot(this.text);
//    for (var style in this.attributes) {
//      root.apply(style);
//    }
//
//    print(root);
//    print("+++++++++");
//
//    return _.Builder.build<TextSpan>(root, (data) {
//      if (data is AttributeStringDataRoot || data is AttributeStringDataParagraph) {
//        return TextSpan(children: []);
//      } else if (data is AttributeStringDataNode) {
//        var styles = data.styles.values.map((style) => _styles[style.key](style.value));
//
//        var mergedStyle = baseStyle ?? TextStyle();
//        for (var style in styles) {
//          mergedStyle = mergedStyle.merge(style);
//        }
//        return TextSpan(text: this.text, style: mergedStyle);
//      }
//      return null;
//    }, (parent, child) {
//      parent.children.add(child);
//    });
//  }
//}
