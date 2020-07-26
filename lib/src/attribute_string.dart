import 'dart:math';

import 'package:attribute_string/src/attribute.dart';
import 'package:attribute_string/src/range.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';

class AttributeString {
  String text;
  List<Attribute> attributes;

  AttributeString({this.text = ""}) {
    attributes = [];
  }

  int get length => this.text.length;

  /// Update attribute after insert a string.
  void _insert(Range process) {
    attributes.forEach((attribute) {
      if (process.start <= attribute.start && attribute.start != attribute.end) {
        attribute.start += process.length;
        attribute.end += process.length;
      } else if (attribute.start <= process.start && process.start < attribute.end) {
        attribute.end += process.length;
      }
    });
  }

  /// Update attribute after delete.
  void _remove(Range process) {
    List<Attribute> removeList = [];
    attributes.forEach((attribute) {
      if (process.start <= attribute.start) {
        attribute.start += process.length;
        attribute.end += process.length;
      } else if (attribute.start < process.start && process.start <= attribute.end) {
        attribute.end += process.length;
        if (attribute.start >= attribute.end) {
          removeList.add(attribute);
        }
      } else if (process.start + process.length < attribute.end) {
        attribute.end = process.start + process.length;
        if (attribute.start >= attribute.end) {
          removeList.add(attribute);
        }
      }
    });

    attributes.removeWhere((element) => removeList.contains(element));
  }

  void insertAttributeString(AttributeString anotherAttributeString, int at) {
    this.insert(anotherAttributeString.text, at);
    for (var attribute in anotherAttributeString.attributes) {
      this.attributes.add(attribute.copy()
        ..start += at
        ..end += at);
    }
    clear();
  }

  void insert(String otherText, int at) {
    text = StringUtils.addCharAtPosition(this.text, otherText, at);
    _insert(Range(at, otherText.length));
  }

  void append(String text) {
    this.insert(text, text.length);
  }

  void remove(int start, int end) {
    text = text.replaceRange(start, end, "");
    _remove(Range(end, start - end));
  }

  /// Add attribute to AttributeString
  void apply(String key, String value, int start, int end) {
    this.attributes.add(Attribute(key, value, start, end));
    clear();
  }

  void addAttribute(Attribute attribute) {
    this.attributes.add(attribute);
    clear();
  }

  void addAttributes(List<Attribute> attributes) {
    this.attributes.addAll(attributes);
    clear();
  }

//  void removeAttribute(String key, int start, int end) {
//    _remove(Range(end, start - end));
//    _insert(Range(start, end - start));
//  }

  void clear() {
    List<Attribute> removeList = [];
    for (var attribute in attributes) {
      if (attribute.start >= text.length) {
        removeList.add(attribute);
        continue;
      } else if (attribute.end >= text.length) {
        attribute.end = text.length;
      }

      for (var another in attributes) {
        if (attribute == another) continue;
        if (attribute.key != another.key) continue;
        if (attribute.end == another.start) {
          removeList.add(another);
          attribute.end = another.end;
        }
        if (another.start <= attribute.start && attribute.end <= another.end) {
          removeList.add(attribute);
        }
      }
    }

    attributes.removeWhere((element) => removeList.contains(element));
  }

  List<Attribute> attributesAt(int at) {
    return attributes.where((element) => element.start <= at && at <= element.end).toList();
  }

  Map<String, dynamic> toJson() =>
      {
        'text': text,
        'attributes': attributes,
      };

  AttributeString.fromJson(Map<String, dynamic> json) {
    fromMap(json);
  }

  fromMap(Map<String, dynamic> json) {
    text = json['text'];
    attributes = json['value'];
    return this;
  }

  AttributeString subAttributeString(int start, int end) {
    var newAttributeString = AttributeString(text: this.text.substring(start, end));

    for (var attribute in attributes) {
      if (attribute.isOverlapWith(start, end)) {
        newAttributeString.addAttribute(attribute.copy()
          ..start = (max(attribute.start, start) - start)
          ..end = (min(attribute.end, end)) - start);
      }
    }

    return newAttributeString;
  }
}

extension AttributeStringEditable on AttributeString {
  void setText(String text, TextSelection oldSelection, TextSelection newSelection) {
    if (this.text == text) {
      this.text = text;
      return;
    }

    this.text = text;

    if (oldSelection.start != oldSelection.end) {
      // replace
      _remove(Range(oldSelection.end, oldSelection.start - oldSelection.end));
      _insert(Range(oldSelection.start, newSelection.start - oldSelection.start));
    } else {
      // insert
      _insert(Range(oldSelection.start, newSelection.start - oldSelection.start));
    }

    clear();
  }
}
