import '../attribute.dart';
import 'attribute_string_data.dart';
import 'attribute_string_data_paragraph.dart';

typedef Transformation<T> = T Function(AttributeStringData attributeStringData);

class AttributeStringDataRoot extends AttributeStringData {
  List<AttributeStringDataParagraph> paragraphs = [];

  AttributeStringDataRoot(String text) {
    paragraphs = text.split('\n').map((e) => AttributeStringDataParagraph(this, e)).toList();
  }

  @override
  String toString() {
    return "Root \n" + paragraphs.join("\n");
  }

  void apply(Attribute style) {
    var count = 0;
    for (var paragraph in this.paragraphs) {
      if (style.start < (count + paragraph.length) && count < style.end) {
        var start = style.start - count;
        if (start < 0) {
          start = 0;
        }
        var end = style.end - count;
        if (end > paragraph.length) {
          end = paragraph.length;
        }

        paragraph.apply(style.key, style.value, start, end);
      }

      count += paragraph.length;
    }
  }

  T transform<T>(Transformation<T> transformation) {
    return transformation(this);
  }
}
