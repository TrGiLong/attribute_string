import 'package:flutter/material.dart';
import 'package:rich_text_editor/src/attribute_string.dart';
import 'package:rich_text_editor/src/text_span/text_span.dart';

class AttributeStringEditingController extends TextEditingController {
  AttributeStringEditingController() : super() {
    this.addListener(() => this._textChanged());
    lastSelection = this.selection;
  }

  AttributeString attributeString = AttributeString();

  TextSelection lastSelection;
  void _textChanged() {
    attributeString.text = this.text;
    lastSelection = this.selection;
  }

  void apply(String key, value, int start, int end) {
    attributeString.apply(key, value, start, end);
  }

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    var textSpan = attributeString.toTextSpan(baseStyle: style);
    return textSpan;
  }
}
