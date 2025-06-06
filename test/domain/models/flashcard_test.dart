import 'package:flutter_test/flutter_test.dart';

import '../../../lib/domain/models/flashcard/flashcard.dart';
import '../../../lib/domain/models/meaning/meaning.dart';
import '../../../lib/domain/models/meaning/part_of_speech.dart';
import '../../../lib/domain/models/media/media.dart';
import '../../../lib/domain/models/word/word.dart';

void main() {
  group('Flashcard', () {
    test('should create Flashcard instance with all required fields', () {
      // Arrange
      const word = Word(
        wordId: 'word_001',
        word: 'hello',
        coreMeaning: 'a greeting',
        explanation: 'A common greeting',
      );

      const meaning = Meaning(
        meaningId: 'meaning_001',
        pos: PartOfSpeech.interjection,
        translation: 'こんにちは',
        pronunciation: 'həˈloʊ',
        exampleEng: 'Hello, world!',
        exampleJpn: 'こんにちは、世界！',
      );

      const media = Media(
        mediaId: 'media_001',
        meaningId: 'meaning_001',
        mediaUrls: ['https://example.com/hello.jpg'],
      );

      // Act
      const flashcard = Flashcard(
        flashcardId: 'flashcard_001',
        word: word,
        meanings: [meaning],
        media: media,
        memo: 'My first flashcard',
        checkFlag: false,
      );

      // Assert
      expect(flashcard.flashcardId, 'flashcard_001');
      expect(flashcard.word, word);
      expect(flashcard.meanings.length, 1);
      expect(flashcard.meanings.first, meaning);
      expect(flashcard.media, media);
      expect(flashcard.memo, 'My first flashcard');
      expect(flashcard.checkFlag, false);
    });

    test('should handle multiple meanings', () {
      // Arrange
      const word = Word(
        wordId: 'word_002',
        word: 'run',
        coreMeaning: 'to move quickly',
        explanation: 'Movement at speed',
      );

      const meaning1 = Meaning(
        meaningId: 'meaning_002',
        pos: PartOfSpeech.intransitiveVerb,
        translation: '走る',
        pronunciation: 'rʌn',
        exampleEng: 'I run every morning',
        exampleJpn: '私は毎朝走ります',
      );

      const meaning2 = Meaning(
        meaningId: 'meaning_003',
        pos: PartOfSpeech.transitiveVerb,
        translation: '経営する',
        pronunciation: 'rʌn',
        exampleEng: 'She runs a company',
        exampleJpn: '彼女は会社を経営しています',
      );

      const media = Media(
        mediaId: 'media_002',
        meaningId: 'meaning_002',
        mediaUrls: [],
      );

      // Act
      const flashcard = Flashcard(
        flashcardId: 'flashcard_002',
        word: word,
        meanings: [meaning1, meaning2],
        media: media,
        memo: '',
        checkFlag: true,
      );

      // Assert
      expect(flashcard.meanings.length, 2);
      expect(flashcard.meanings[0].pos, PartOfSpeech.intransitiveVerb);
      expect(flashcard.meanings[1].pos, PartOfSpeech.transitiveVerb);
      expect(flashcard.checkFlag, true);
    });
  });
}