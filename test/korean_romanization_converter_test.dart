import 'package:flutter_test/flutter_test.dart';

import 'package:korean_romanization_converter/korean_romanization_converter.dart';

void main() {
  test('korean romanization converter', () {
    final converter = KoreanRomanizationConverter();
    expect(converter.romanize('안녕하세요?'), 'annyeonghaseyo?');
  });
}
