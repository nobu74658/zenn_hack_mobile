import 'package:result_dart/result_dart.dart';

import '../../../domain/models/word/word.dart';

/// Abstract repository interface for Word entity
abstract class WordRepository {
  /// Gets all words
  Future<Result<List<Word>>> getWords();

  /// Gets a single word by ID
  Future<Result<Word>> getWord(int id);

  /// Creates a new word
  Future<Result<Word>> createWord(Word word);

  /// Updates an existing word
  Future<Result<Word>> updateWord(Word word);

  /// Deletes a word by ID
  Future<Result<void>> deleteWord(int id);

  /// Searches words by text
  Future<Result<List<Word>>> searchWords(String query);
}