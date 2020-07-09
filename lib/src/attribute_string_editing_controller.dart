import 'package:flutter/material.dart';
import 'package:rich_text_editor/src/attribute_string.dart';
import 'package:rich_text_editor/src/convert/text_span.dart';

class AttributeStringEditingController extends TextEditingController {
  AttributeStringEditingController() : super() {
    this.addListener(() => this._textChanged());
  }

  AttributeString attributeString = AttributeString();

  TextSelection lastSelection;

  void _textChanged() {
    if (this.lastSelection == null) {
      attributeString.text = this.text;
      lastSelection = this.selection;
      print('object');
      return;
    }

    print(text);
    print(lastSelection);
    print(this.selection);
    print('=========');

    attributeString.setText(this.text, lastSelection, this.selection);
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
