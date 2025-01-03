library korean_romanization_converter;

/// A Calculator.
class KoreanRomanizationConverter {
  String romanize(String text) {
    List<String> wordList = [];

    for (var word in text.split(' ')) {
      wordList.add(romanizeWord(word));
    }

    return wordList.join(' ');
  }

  String romanizeWord(String text) {
    String result = '';

    for (var code in text.runes.toList()) {
      var character = String.fromCharCode(code);

      result += KoreanRomanizationConverter()
          .romanizeChar(Disassemble().disassembleChar(character));
    }

    return result;
  }

  String romanizeChar(List<String> textList) {
    if (textList.length < 2) {
      if (Table().initials.containsKey(textList[0])) {
        return Table().initials[textList[0]]!;
      }

      if (Table().medials.containsKey(textList[0])) {
        return Table().medials[textList[0]]!;
      }

      if (Table().finals.containsKey(textList[0])) {
        return Table().finals[textList[0]]!;
      }

      return textList[0];
    }

    var initial = Table().initials[textList[0]];
    var medial = Table().medials[textList[1]];
    var final2 = Table().finals[textList[2]];

    return '$initial$medial${final2 ?? ''}'.replaceAll('-', '');
  }
}

class Alphabet {
  var initials = [
    'ㄱ',
    'ㄲ',
    'ㄴ',
    'ㄷ',
    'ㄸ',
    'ㄹ',
    'ㅁ',
    'ㅂ',
    'ㅃ',
    'ㅅ',
    'ㅆ',
    'ㅇ',
    'ㅈ',
    'ㅉ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ'
  ];
  var medials = [
    'ㅏ',
    'ㅐ',
    'ㅑ',
    'ㅒ',
    'ㅓ',
    'ㅔ',
    'ㅕ',
    'ㅖ',
    'ㅗ',
    'ㅘ',
    'ㅙ',
    'ㅚ',
    'ㅛ',
    'ㅜ',
    'ㅝ',
    'ㅞ',
    'ㅟ',
    'ㅠ',
    'ㅡ',
    'ㅢ',
    'ㅣ'
  ];
  var finals = [
    '',
    'ㄱ',
    'ㄲ',
    'ㄳ',
    'ㄴ',
    'ㄵ',
    'ㄶ',
    'ㄷ',
    'ㄹ',
    'ㄺ',
    'ㄻ',
    'ㄼ',
    'ㄽ',
    'ㄾ',
    'ㄿ',
    'ㅀ',
    'ㅁ',
    'ㅂ',
    'ㅄ',
    'ㅅ',
    'ㅆ',
    'ㅇ',
    'ㅈ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ'
  ];

  // Korean unicode range
  var unicodeStart = 0xAC00;
  var unicodeEnd = 0xD7A3;

  isVowel(char) {
    return isMedial(char);
  }

  isConsonant(char) {
    return isInitial(char) || isFinal(char);
  }

  isInitial(char) {
    return has(initials, char);
  }

  isMedial(char) {
    return has(medials, char);
  }

  isFinal(char) {
    return has(finals, char);
  }

  has(array, item) {
    return array.indexOf(item) != -1;
  }
}

class Disassemble {
  List<String> breakComplexChar(String text) {
    var charCode = text.codeUnitAt(0);
    var code = charCode - Alphabet().unicodeStart;

    var final2 = code % 28;
    var medial = ((code - final2) / 28) % 21;
    var intial = (((code - final2) / 28) - medial) / 21;

    return [
      Alphabet().initials[intial.toInt()],
      Alphabet().medials[medial.toInt()],
      Alphabet().finals[final2.toInt()]
    ];
  }

  List<String> disassembleChar(String text) {
    // Return vowels and consonants as is
    if (Alphabet().isVowel(text) || Alphabet().isConsonant(text)) {
      return [text];
    }

    // Work on unicode code
    if (!isComplexChar(text)) {
      return [text];
    }

    return breakComplexChar(text);
  }

  bool isComplexChar(String text) {
    var code = text.codeUnitAt(0);
    return (code >= Alphabet().unicodeStart && Alphabet().unicodeEnd >= code);
  }
}

//https://github.com/crizin/korean-romanizer/blob/master/src/main/java/net/crizin/KoreanCharacter.java 참고함
class Table {
  var initials = {
    // Consonants
    'ㄱ': 'g',
    'ㄴ': 'n',
    'ㄷ': 'd',
    'ㄹ': 'r',
    'ㅁ': 'm',
    'ㅂ': 'b',
    'ㅅ': 's',
    'ㅇ': '',
    'ㅈ': 'j',
    'ㅊ': 'ch',
    'ㅋ': 'k',
    'ㅌ': 't',
    'ㅍ': 'p',
    'ㅎ': 'h',
    // Double consonants
    'ㄲ': 'kk',
    'ㄸ': 'tt',
    'ㅃ': 'pp',
    'ㅆ': 'ss',
    'ㅉ': 'jj',
  };
  var medials = {
    // Vowels
    'ㅏ': 'a',
    'ㅓ': 'eo',
    'ㅗ': 'o',
    'ㅜ': 'u',
    'ㅡ': 'eu',
    'ㅣ': 'i',
    'ㅐ': 'ae',
    'ㅔ': 'e',
    'ㅚ': 'oe',
    'ㅟ': 'wi',
    'ㅢ': 'ui',
    // Vowels (y+)
    'ㅑ': 'ya',
    'ㅕ': 'yeo',
    'ㅛ': 'yo',
    'ㅠ': 'yu',
    'ㅒ': 'yae',
    'ㅖ': 'ye',
    // Vowels (w+)
    'ㅘ': 'wa',
    'ㅝ': 'wo',
    'ㅙ': 'wae',
    'ㅞ': 'we',
  };
  var finals = {
    // Finals
    'ㄱ': 'k',
    'ㄴ': 'n',
    'ㄷ': 't',
    'ㄹ': 'l',
    'ㅁ': 'm',
    'ㅂ': 'p',
    'ㅅ': 't',
    'ㅇ': 'ng',
    'ㅈ': 't',
    'ㅊ': 'ch',
    'ㅋ': 'k',
    'ㅌ': 't',
    'ㅍ': 'p',
    'ㅎ': 't',

    'ㄲ': 'k',
    'ㄵ': 'n',
    'ㄺ': 'k',
    'ㅄ': 'p',
    'ㅆ': 't',

    'ㄳ': 'k',
    'ㄶ': 'n',
    'ㄻ': 'm',

    'ㄼ': 'l',
    'ㄽ': 'l',
    'ㄾ': 'l',
    'ㄿ': 'l',
    'ㅀ': 'l',
  };
}
