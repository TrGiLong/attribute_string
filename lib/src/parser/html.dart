import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;
import 'package:attribute_string/attribute_string.dart';

class HTMLParser {
  static AttributeString parse(String text) {
    var document = html.parse(text);
    var attributeString = AttributeString();

    var body = document.getElementsByTagName('body');
    if (body.length == 0) return attributeString;

    _parseNode(attributeString, body[0]);

    print('object');
    print(attributeString.attributes);

    return attributeString;
  }

  static _parseNode(AttributeString attributeString, Node node) {
    for (var node in node.nodes) {
      switch (node.nodeType) {
        case 1:
          {
            int start = attributeString.text.length;
            _parseNode(attributeString, node);

            Element element = node;
            if (element.localName == 'p') {
              attributeString.text += '\n';
            } else {
              attributeString.addAttributes(_parseStyle(element, start, attributeString.text.length));
            }
            break;
          }
        case 3:
          {
            attributeString.text += node.text;
            break;
          }
      }
    }
  }

  static List<Attribute> _parseStyle(Element element, int start, int end) {
    switch (element.localName) {
      case 'b':
        return [Attribute(Attribute.Bold, null, start, end)];
      case 'i':
        return [Attribute(Attribute.Italic, null, start, end)];
      case 'a':
        return [Attribute(Attribute.Link, element.attributes['href'], start, end)];
      case 'span':
        {
          var style = element.attributes['style'];
          if (style == null) return [];

          var styleSheet = _cssParse(style);
          List<Attribute> attributes = [];
          styleSheet.forEach((key, value) {
            switch (key) {
              case 'text-decoration':
                {
                  if (value == 'line-through') {
                    attributes.add(Attribute(Attribute.Strikethrough, null, start, end));
                  } else if (value == 'underline') {
                    attributes.add(Attribute(Attribute.Underline, null, start, end));
                  }
                  break;
                }
              case 'color':
                {
                  attributes.add(Attribute(Attribute.Color, value, start, end));
                  break;
                }
              case 'font-family':
                {
                  attributes.add(Attribute(Attribute.Font, value, start, end));
                  break;
                }
              case 'font-size':
                {
                  attributes.add(Attribute(Attribute.Size, value.replaceAll(RegExp(r'[^\w\s]+'), ''), start, end));
                  break;
                }
            }
          });
          return attributes;
        }

      default:
        return [];
    }
  }

  static Map<String, String> _cssParse(String css) {
    Map<String, String> result = Map();
    for (var style in css.split(';')) {
      var keyAndValue = style.split(':');
      result[keyAndValue[0]] = keyAndValue[1];
    }
    return result;
  }
}
