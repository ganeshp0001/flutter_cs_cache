import 'package:test/test.dart';

import 'package:flutter_cs_cache/flutter_cs_cache.dart';

void main() {
  test('Test cache entry is null', () {
    final CsCache csCache = new CsCache();
    final String cacheValue = csCache.getKey(key: "randomkey-${DateTime.now().millisecondsSinceEpoch}"  );
    expect(cacheValue, null);
  });
}
