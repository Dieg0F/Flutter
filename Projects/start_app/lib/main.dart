import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 1),
        appBar: AppBar(
          title: Text("List Flutter"),
          backgroundColor: Color.fromRGBO(20, 20, 20, 1),
          elevation: 10,
          centerTitle: false,
        ),
        body: RandomWords(),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomStateWidget createState() => RandomStateWidget();
}

class RandomStateWidget extends State<RandomWords> {

  final _suggestions = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return _buildSuggestList();
  }

  Widget _buildSuggestList() {
    return ListView.builder(
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider(
            color: Color.fromRGBO(255, 255, 255, 0.2),
          ); /*2*/
          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(16, 4, 16, 4),
      title: Text(
        pair.asPascalCase,
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontStyle: FontStyle.italic
        ),
      ),
    );
  }
}