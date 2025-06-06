import 'package:flutter_test/flutter_test.dart';

import '../../../lib/domain/models/word/word.dart';

void main() {
  group('Word', () {
    test('should create Word instance with all required fields', () {
      // Arrange & Act
      const word = Word(
        wordId: 'word_001',
        word: 'hello',
        coreMeaning: 'a greeting',
        explanation: 'A common greeting used when meeting someone',
      );

      // Assert
      expect(word.wordId, 'word_001');
      expect(word.word, 'hello');
      expect(word.coreMeaning, 'a greeting');
      expect(word.explanation, 'A common greeting used when meeting someone');
    });

    test('should support value equality', () {
      // Arrange
      const word1 = Word(
        wordId: 'word_001',
        word: 'hello',
        coreMeaning: 'a greeting',
        explanation: 'A common greeting',
      );

      const word2 = Word(
        wordId: 'word_001',
        word: 'hello',
        coreMeaning: 'a greeting',
        explanation: 'A common greeting',
      );

      // Act & Assert
      expect(word1, equals(word2));
    });
  });
}