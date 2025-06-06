import 'package:flutter_test/flutter_test.dart';
import 'package:result_dart/result_dart.dart';
import 'package:zenn_hack_mobile/data/repositories/word/word_repository_local.dart';
import 'package:zenn_hack_mobile/data/services/local_data_service.dart';
import 'package:zenn_hack_mobile/domain/models/word/word.dart';

void main() {
  group('WordRepositoryLocal', () {
    late WordRepositoryLocal repository;
    late LocalDataService localDataService;

    setUp(() {
      localDataService = LocalDataService();
      repository = WordRepositoryLocal(localDataService: localDataService);
    });

    test('should return success result for getWords', () async {
      // Act
      final result = await repository.getWords();

      // Assert
      expect(result.isSuccess(), true);
      switch (result) {
        case Ok<List<Word>>():
          expect(result.value, isA<List<Word>>());
        case Error<List<Word>>():
          fail('Expected success but got error: ${result.error}');
      }
    });

    test('should return error for non-existent word ID', () async {
      // Act
      final result = await repository.getWord(999);

      // Assert
      expect(result.isError(), true);
      switch (result) {
        case Ok<Word>():
          fail('Expected error but got success');
        case Error<Word>():
          expect(result.error.toString(), contains('Word not found'));
      }
    });

    test('should successfully search words', () async {
      // Act
      final result = await repository.searchWords('run');

      // Assert
      expect(result.isSuccess(), true);
      switch (result) {
        case Ok<List<Word>>():
          expect(result.value, isA<List<Word>>());
        case Error<List<Word>>():
          fail('Expected success but got error: ${result.error}');
      }
    });

    test('should return success for createWord', () async {
      // Arrange
      const word = Word(
        wordId: 100,
        word: 'test',
        coreMeaning: 'a trial',
        explanation: 'A procedure to establish quality',
      );

      // Act
      final result = await repository.createWord(word);

      // Assert
      expect(result.isSuccess(), true);
      switch (result) {
        case Ok<Word>():
          expect(result.value, equals(word));
        case Error<Word>():
          fail('Expected success but got error: ${result.error}');
      }
    });
  });
}