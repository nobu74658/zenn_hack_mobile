import 'package:flutter_test/flutter_test.dart';

import '../../../lib/domain/models/meaning/meaning.dart';
import '../../../lib/domain/models/meaning/part_of_speech.dart';

void main() {
  group('Meaning', () {
    test('should create Meaning instance with all required fields', () {
      // Arrange & Act
      const meaning = Meaning(
        meaningId: 'meaning_001',
        pos: PartOfSpeech.noun,
        translation: 'こんにちは',
        pronunciation: 'həˈloʊ',
        exampleEng: 'Hello, how are you?',
        exampleJpn: 'こんにちは、元気ですか？',
      );

      // Assert
      expect(meaning.meaningId, 'meaning_001');
      expect(meaning.pos, PartOfSpeech.noun);
      expect(meaning.translation, 'こんにちは');
      expect(meaning.pronunciation, 'həˈloʊ');
      expect(meaning.exampleEng, 'Hello, how are you?');
      expect(meaning.exampleJpn, 'こんにちは、元気ですか？');
    });

    test('should support all PartOfSpeech enum values', () {
      // Assert
      expect(PartOfSpeech.values.length, 9);
      expect(PartOfSpeech.values, contains(PartOfSpeech.noun));
      expect(PartOfSpeech.values, contains(PartOfSpeech.pronoun));
      expect(PartOfSpeech.values, contains(PartOfSpeech.intransitiveVerb));
      expect(PartOfSpeech.values, contains(PartOfSpeech.transitiveVerb));
      expect(PartOfSpeech.values, contains(PartOfSpeech.adjective));
      expect(PartOfSpeech.values, contains(PartOfSpeech.adverb));
      expect(PartOfSpeech.values, contains(PartOfSpeech.preposition));
      expect(PartOfSpeech.values, contains(PartOfSpeech.conjunction));
      expect(PartOfSpeech.values, contains(PartOfSpeech.interjection));
    });
  });
}