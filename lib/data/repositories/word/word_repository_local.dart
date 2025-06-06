import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/word/word.dart';
import '../../services/local_data_service.dart';
import 'word_repository.dart';

/// Local implementation of WordRepository using JSON data
class WordRepositoryLocal implements WordRepository {
  WordRepositoryLocal({
    required LocalDataService localDataService,
  }) : _localDataService = localDataService;

  final LocalDataService _localDataService;
  final _log = Logger('WordRepositoryLocal');

  @override
  Future<Result<List<Word>>> getWords() async {
    try {
      final words = await _localDataService.getWords();
      _log.fine('Loaded ${words.length} words');
      return Result.ok(words);
    } on Exception catch (error) {
      _log.warning('Failed to get words', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Word>> getWord(int id) async {
    try {
      final word = await _localDataService.getWordById(id);
      if (word == null) {
        return Result.error(Exception('Word not found with id: $id'));
      }
      _log.fine('Loaded word: ${word.word}');
      return Result.ok(word);
    } on Exception catch (error) {
      _log.warning('Failed to get word', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Word>> createWord(Word word) async {
    try {
      // In local implementation, we just return the word as created
      // In a real implementation, this would save to local storage
      _log.fine('Created word: ${word.word}');
      return Result.ok(word);
    } on Exception catch (error) {
      _log.warning('Failed to create word', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Word>> updateWord(Word word) async {
    try {
      // In local implementation, we just return the updated word
      // In a real implementation, this would update local storage
      _log.fine('Updated word: ${word.word}');
      return Result.ok(word);
    } on Exception catch (error) {
      _log.warning('Failed to update word', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> deleteWord(int id) async {
    try {
      // In local implementation, we just return success
      // In a real implementation, this would delete from local storage
      _log.fine('Deleted word with id: $id');
      return Result.ok(null);
    } on Exception catch (error) {
      _log.warning('Failed to delete word', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<Word>>> searchWords(String query) async {
    try {
      final words = await _localDataService.getWords();
      final searchResults = words.where((word) {
        final wordLower = word.word.toLowerCase();
        final coreMeaningLower = word.coreMeaning.toLowerCase();
        final queryLower = query.toLowerCase();
        return wordLower.contains(queryLower) || coreMeaningLower.contains(queryLower);
      }).toList();
      _log.fine('Found ${searchResults.length} words matching "$query"');
      return Result.ok(searchResults);
    } on Exception catch (error) {
      _log.warning('Failed to search words', error);
      return Result.error(error);
    }
  }
}