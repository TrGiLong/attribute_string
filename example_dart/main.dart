import 'package:rich_text_editor/src/attribute.dart';
import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data_root.dart';

void main() {
  AttributeStringDataRoot root = AttributeStringDataRoot("0123456789 \n abcdef");
  print(root);

  print("-----------");
  root.apply(Attribute('bold', null, 3, 16));
  root.apply(Attribute('italic', null, 7, 13));
  print(root);
}