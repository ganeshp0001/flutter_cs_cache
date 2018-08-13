import 'package:flutter/material.dart';

import 'package:flutter_cs_cache/flutter_cs_cache.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Cache Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String cacheMessage = "";
  final CsCache cache = new CsCache();
  final String _cacheKey = "1111";

  void _checkCache() {
    String cacheEntry = cache.getKey(key: _cacheKey);
    if(cacheEntry == null) cache.setKey(key: _cacheKey, value: DateTime.now().toString(), expireOn: DateTime.now().add(new Duration(seconds: 300)).millisecondsSinceEpoch);
    setState(() {
      cacheMessage = cacheEntry ?? "Cache entry not found";
    });
  }

  void _removeCacheEntry(){
    cache.removeKey(key: _cacheKey);
    _checkCache();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Cache has following value:',
              style: Theme.of(context).textTheme.title,
            ),
            new Text(
              '$cacheMessage',
              style: Theme.of(context).textTheme.body1,
            ),

            SizedBox(height: 50.0,),
            RaisedButton(
              child: Text("Remove Cache Entry"),
              onPressed: _removeCacheEntry,
              )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _checkCache,
        tooltip: 'Add cache entry',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
