//import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data.dart';
//import 'package:rich_text_editor/src/attribute_string_data/attribute_string_data_root.dart';
//
//typedef DataTransformer<T> = T Function(AttributeStringData data);
//typedef DataInsert<T> = void Function(T parent, T child);
//
//class Builder {
//  static T build<T>(AttributeStringDataRoot root, DataTransformer<T> dataTransformer, DataInsert<T> dataInsert) {
//    var transformedRoot = dataTransformer(root);
//    for (var paragraph in root.paragraphs) {
//      var transformedParagraph = dataTransformer(paragraph);
//      for (var node in paragraph.nodes) {
//        var transformedNode = dataTransformer(node);
//        dataInsert(transformedParagraph, transformedNode);
//      }
//      dataInsert(transformedRoot, transformedParagraph);
//    }
//    return transformedRoot;
//  }
//}