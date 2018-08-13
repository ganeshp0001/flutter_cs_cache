library flutter_cs_cache;

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A Calculator.
class CsCache {
  static CsCache _singltonInstance;
  SharedPreferences _sharedPreferences;

  factory CsCache() {
    if (_singltonInstance == null) {
      _singltonInstance = CsCache._internal();
      _singltonInstance._setSharedPref();
    }

    return _singltonInstance;
  }

  CsCache._internal();

  void _setSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  bool isValid(List<String> cacheValueEntry) {
    try {
      if (cacheValueEntry != null &&
          cacheValueEntry.isNotEmpty &&
          cacheValueEntry.length == 2) {
        int expiryTimestamp = int.parse(cacheValueEntry[0]);
        return (expiryTimestamp >= DateTime.now().millisecondsSinceEpoch);
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  void setKey(
      {@required String key, @required String value, int expireOn = -1}) {
    List<String> cacheValueEntry = [expireOn.toString(), value];

    _sharedPreferences.setStringList(key, cacheValueEntry);
  }

  String getKey({@required String key}) {
    List<String> cacheValueEntry = _sharedPreferences.getStringList(key);
    if (isValid(cacheValueEntry)) {
      return cacheValueEntry[1];
    }

    return null;
  }

  void removeKey({@required String key}) {
    _sharedPreferences.remove(key);
  }

  void purgeCache() {
    Set<String> keys = _sharedPreferences.getKeys();
    for (String key in keys) {
      if (getKey(key: key) == null) {
        _sharedPreferences.remove(key);
      }
    }
  }

  void clearCache() {
    _sharedPreferences.clear();
  }
}
