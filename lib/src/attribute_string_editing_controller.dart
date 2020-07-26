import 'package:attribute_string/src/attribute_string.dart';
import 'package:attribute_string/src/convert/text_span.dart';
import 'package:flutter/material.dart';

class AttributeStringEditingController extends TextEditingController {
  AttributeStringEditingController({AttributeString attributeString})
      : super(text: attributeString != null ? attributeString.text : null) {
    if (attributeString != null)
      _attributeString = attributeString;
    else
      _attributeString = AttributeString();

    this.addListener(() => this._textChanged());
  }

  AttributeString _attributeString;

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
    if (start == end) return;
    attributeString.apply(key, value, start, end);
  }

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    var textSpan = attributeString.toTextSpan(baseStyle: style);
    return textSpan;
  }

  void insertAttributeString(AttributeString anotherAttributeString, int at) {
    this.attributeString.insertAttributeString(anotherAttributeString, at);
    this.text = attributeString.text;
  }
}
