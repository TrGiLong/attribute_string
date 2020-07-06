class Attribute {
  String key;
  String value;

  int start;
  int end;

  Attribute(this.key, this.value, this.start, this.end);

  @override
  String toString() {
    return "$key: $value";
  }

  bool containIndex(int index) {
    return this.start <= index && index <= this.end;
  }

  bool isOverlapWith(int start, int end) {
    return this.start <= end && start <= this.end;
  }

  bool containRange(int start, int end) {
    return this.start < start && end < this.end;
  }

  static const String Bold = "bold";
  static const String Italic = "italic";
  static const String Underline = "underline";
  static const String Size = "size";
  static const String Font = "font";
  static const String Link = "link";
}

class AttributeBold extends Attribute {
  AttributeBold(String key, String value, int start, int end) : super(key, value, start, end);
  
}