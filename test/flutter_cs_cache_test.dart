import 'package:test/test.dart';

import 'package:flutter_cs_cache/flutter_cs_cache.dart';

void main() {
  test('Test cache entry is null', () {
    final csCache = new CsCache();
    expect(csCache.getKey(key: "randomkey"), null);
  });
}
