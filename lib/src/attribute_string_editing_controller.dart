import 'package:flutter/material.dart';
import 'package:attribute_string/src/attribute_string.dart';
import 'package:attribute_string/src/convert/text_span.dart';

class AttributeStringEditingController extends TextEditingController {
  AttributeStringEditingController() : super() {
    this.addListener(() => this._textChanged());
  }

  AttributeString _attributeString = AttributeString();

  AttributeString get attributeString => _attributeString;

  set attributeString(AttributeString value) {
    _attributeString = value;
    this.text = _attributeString.text;
  }

  TextSelection _lastSelection;

  void _textChanged() {
    if (this._lastSelection == null) {
      _attributeString.text = this.text;
      _lastSelection = this.selection;
      return;
    }

    _attributeString.setText(this.text, _lastSelection, this.selection);
    _lastSelection = this.selection;
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
