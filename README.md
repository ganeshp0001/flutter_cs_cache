# flutter_cs_cache

Flutter package to provide simple and extendible cache feature to be used in flutter applications.

## Getting Started
Import CsCache as 

```import 'package:flutter_cs_cache/flutter_cs_cache.dart';```

Once imported make sure you have created CsCache instance ahead of time, before using getKey or setKey functions

### To set a key value
csCache.setKey(key: keyName, value: valueString, expireOn: expiryTimeInMillisecondsSinceEpoch);

### To get a key value
csCache.getKey(key: keyName);

### To remove a key value
csCache.removeKey(key: keyName);

### To purge all keys which might have been expired
csCache.purgeCache();

### To clear all cache entrie (expired and non-expired)
csCache.clearCache();


## example code

``` dart
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
```
