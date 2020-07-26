import 'package:attribute_string/attribute_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AttributeStringEditingController controller = AttributeStringEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
//      var result = HTMLParser.parse('<p>abc</p><p>def Montag <b>Montag Dienstag criti</b></p><p><b>drfgsfd </b><span style="text-decoration:line-through"><b>fsdds</b></span><b> das </b></p>');
      controller.attributeString = AttributeString();
    });

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  controller: controller,
                  maxLines: 999,
                ),
              )),
              SelectableText(controller.attributeString.toTextSpan().toStringDeep()),
              HtmlWidget(
                controller.attributeString.toHtml(),
              ),
              Row(
                children: <Widget>[
                  FlatButton(
                    child: Text("Bold"),
                    onPressed: () {
                      setState(() {
                        controller.apply(Attribute.Bold, null, controller.selection.start, controller.selection.end);
                      });

                    },
                  ),
                  FlatButton(
                    child: Text("Strikethrough"),
                    onPressed: () {
                      setState(() {
                        controller.apply(
                            Attribute.Strikethrough, null, controller.selection.start, controller.selection.end);
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
