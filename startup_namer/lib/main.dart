import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Name Generator',
      home: RandomWords(),
      theme: ThemeData(
        // Add the 3 lines from here...
        primaryColor: Colors.indigo,
        primaryColorLight: Colors.green,
        accentColor: Colors.indigoAccent,
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
  final _saved = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Generator'),
        actions: <Widget>[
          // Add 3 lines from here...
          IconButton(icon: Icon(Icons.star), onPressed: _pushSaved),
        ],
        backgroundColor: Colors.indigo, // ... to here.
      ),
      body: _buildSuggestList(),
    );
  }

  Widget _buildSuggestList() {
    return ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd)
        return Divider(
          color: Color.fromRGBO(0, 0, 0, 0.09),
        );
      /*2*/
      final index = i ~/ 2; /*3*/
      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10)); /*4*/
      }
      return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    final bool removedWord = _saved.contains(pair);

    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(16, 4, 16, 4),
      trailing: Icon(
        // Add the lines from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : Colors.blueGrey,
      ),
      // ... to here.
      title: Text(
        pair.asPascalCase,
        style: TextStyle(color: Colors.blueGrey, fontStyle: FontStyle.italic),
      ),
      onLongPress: () {
        setState(() {
          if (removedWord) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(pair.asPascalCase),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
                title: Text('Saved Suggestions'),
                backgroundColor: Colors.indigo),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
