class Attribute {
  String key;
  String value = "";

  int start;
  int end;

  Attribute(this.key, this.value, this.start, this.end);

  Attribute copy() => Attribute(key, value, start, end);

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
        'start': start,
        'end': end,
      };

  Attribute.fromJson(Map<String, dynamic> json) {
    fromMap(json);
  }

  fromMap(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    start = json['start'];
    end = json['end'];
    return this;
  }

  @override
  String toString() {
    return "$key: $value [$start:$end]";
  }

  bool containIndex(int index) {
    return this.start <= index && index <= this.end;
  }

  bool isOverlapWith(int start, int end) {
    return this.start <= end && start <= this.end;
  }

  bool containRange(int start, int end) {
    return this.start <= start && end <= this.end;
  }

  static const String Bold = "bold";
  static const String Italic = "italic";
  static const String Underline = "underline";
  static const String Size = "size";
  static const String Font = "font";
  static const String Link = "link";
  static const String Color = "color";
  static const String Strikethrough = "strikethrough";
}
