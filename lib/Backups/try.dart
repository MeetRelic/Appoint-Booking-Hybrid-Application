import 'dart:async';
import 'package:flutter/material.dart';

// void main() {
//   runApp(new MaterialApp(
//     home: new Scaffold(
//       appBar: new AppBar(title: new Text('Example App')),
//       body: new textList(),
//     ),
//   ));
// }

class TextList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() =>
      new _textListState();
}

class _textListState extends State<TextList>
    with TickerProviderStateMixin {

  List<Widget> items = new List();
  Widget lorem = new textClass("Lorem");
  Timer timer;

  @override
  void initState() {
    super.initState();

    items.add(new textClass("test"));
    items.add(new textClass("test"));

    timer = new Timer.periodic(new Duration(seconds: 5), (Timer timer) {
      setState(() {
        items.removeAt(0);
        items.add(lorem);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> content = ListTile.divideTiles(
        context: context, tiles: items).toList();

    return new Column(
      children: content,
    );
  }
}

class textClass extends StatefulWidget {
  textClass(this.word);

  final String word;

  @override
  State<StatefulWidget> createState() =>
      new _textClass();
}

class _textClass extends State<textClass>
    with TickerProviderStateMixin {
  _textClass();

  String word;
  Timer timer;

  @override
  void didUpdateWidget(textClass oldWidget) {
    if (oldWidget.word != widget.word) {
      word = widget.word;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    word = widget.word;

    timer = new Timer.periodic(new Duration(seconds: 2), (Timer timer) {
      setState(() {
        word += "t";
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return new Text(word);
  }
}