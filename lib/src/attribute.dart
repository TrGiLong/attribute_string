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
}

extension AttributeUtils on Attribute {
  bool containIndex(int index) {
    return this.start <= index && index <= this.end;
  }
}
