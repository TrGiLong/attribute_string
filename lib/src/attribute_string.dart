import 'package:flutter/cupertino.dart';
import 'package:rich_text_editor/src/attribute.dart';

class AttributeString {
  String text;
  List<Attribute> attributes;

  AttributeString({this.text = ""}) {
    attributes = [];
  }

  void setText(String text, TextSelection oldSelection, TextSelection newSelection) {
    if (this.text == text) {
      this.text = text;
      return;
    }

    this.text = text;

    if (oldSelection.start != oldSelection.end) {
      // replace
      _remove(_RangeProcess(oldSelection.end, oldSelection.start - oldSelection.end));
      _insert(_RangeProcess(oldSelection.start, newSelection.start - oldSelection.start));
    } else {
      // insert
      _insert(_RangeProcess(oldSelection.start, newSelection.start - oldSelection.start));
    }
  }

  void _insert(_RangeProcess process) {
    attributes.forEach((attribute) {
      if (process.start <= attribute.start && attribute.start != attribute.end) {
        attribute.start += process.length;
        attribute.end += process.length;
      } else if (attribute.start <= process.start && process.start <= attribute.end) {
        attribute.end += process.length;
      }
    });
  }

  void _remove(_RangeProcess process) {
    List<Attribute> removeList = [];
    attributes.forEach((attribute) {
      if (process.start <= attribute.start) {
        print('1');
        print(process.length);
        attribute.start += process.length;
        attribute.end += process.length;
        print([attribute.start, attribute.end]);
      } else if (attribute.start < process.start && process.start <= attribute.end) {
        print('2');
        attribute.end += process.length;
        if (attribute.start >= attribute.end) {
          removeList.add(attribute);
        }
      } else if (process.start + process.length < attribute.end) {
        print('3');
        attribute.end = process.start + process.length;
        if (attribute.start >= attribute.end) {
          removeList.add(attribute);
        }
      }
    });

    attributes.removeWhere((element) => removeList.contains(element));
  }

//  void insert(String otherText, int at) {
//    text = StringUtils.addCharAtPosition(this.text, otherText, at);
//
//    for (var attribute in attributes) {
//      if (at <= attribute.start) {
//        attribute.start += otherText.length;
//        attribute.end += otherText.length;
//      } else if (attribute.start < at && at < attribute.end) {
//        attribute.end += otherText.length;
//      }
//    }
//
//    attributes.removeWhere((attribute) {
//      return attribute.start > text.length || attribute.start > attribute.end;
//    });
//  }
//
//  void append(String text) {
//    this.insert(text, text.length);
//  }

  void apply(String key, String value, int start, int end) {
    attributes.add(Attribute(key, value, start, end));
    clear();
  }

  void clear() {
    List<Attribute> removeList = [];
    for (var attribute in attributes) {
      for (var another in attributes) {
        if (attribute == another) continue;
        if (attribute.key != another.key) continue;
        if (attribute.end == another.start) {
          removeList.add(another);
          attribute.end = another.start;
        }
        if (another.start <= attribute.start && attribute.end <= another.end) {
          removeList.add(attribute);
        }
      }
    }

    print(removeList);
    attributes.removeWhere((element) => removeList.contains(element));
  }

  List<Attribute> attributesAt(int at) {
    return attributes.where((element) => element.start <= at && at <= element.end).toList();
  }

  Map<String, dynamic> toJson() => {
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
}

class _RangeProcess {
  int start;
  int length;

  _RangeProcess(this.start, this.length);
}
