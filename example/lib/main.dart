import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rich_text_editor/rich_text_editor.dart';

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
                child: TextField(
                  controller: controller,
                  maxLines: 999,
                ),
              )),
              SelectableText(controller.attributeString.toJsonTree()),
              Row(
                children: <Widget>[
                  FlatButton(
                    child: Text("Underline"),
                    onPressed: () {
                      setState(() {
                        setState(() {
                          controller.apply(
                              Attribute.Underline, null, controller.selection.start, controller.selection.end);
                        });

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
