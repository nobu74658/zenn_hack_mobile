import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/flashcard/flashcard.dart';
import '../../services/local_data_service.dart';
import 'flashcard_repository.dart';

/// Local implementation of FlashcardRepository using JSON data
class FlashcardRepositoryLocal implements FlashcardRepository {
  FlashcardRepositoryLocal({
    required LocalDataService localDataService,
  }) : _localDataService = localDataService;

  final LocalDataService _localDataService;
  final _log = Logger('FlashcardRepositoryLocal');

  @override
  Future<Result<List<Flashcard>>> getFlashcards() async {
    try {
      final flashcards = await _localDataService.getFlashcards();
      _log.fine('Loaded ${flashcards.length} flashcards');
      return Result.ok(flashcards);
    } on Exception catch (error) {
      _log.warning('Failed to get flashcards', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Flashcard>> getFlashcard(int id) async {
    try {
      final flashcard = await _localDataService.getFlashcardById(id);
      if (flashcard == null) {
        return Result.error(Exception('Flashcard not found with id: $id'));
      }
      _log.fine('Loaded flashcard: ${flashcard.word.word}');
      return Result.ok(flashcard);
    } on Exception catch (error) {
      _log.warning('Failed to get flashcard', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Flashcard>> createFlashcard(Flashcard flashcard) async {
    try {
      // In local implementation, we just return the flashcard as created
      // In a real implementation, this would save to local storage
      _log.fine('Created flashcard: ${flashcard.word.word}');
      return Result.ok(flashcard);
    } on Exception catch (error) {
      _log.warning('Failed to create flashcard', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Flashcard>> updateFlashcard(Flashcard flashcard) async {
    try {
      // In local implementation, we just return the updated flashcard
      // In a real implementation, this would update local storage
      _log.fine('Updated flashcard: ${flashcard.word.word}');
      return Result.ok(flashcard);
    } on Exception catch (error) {
      _log.warning('Failed to update flashcard', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> deleteFlashcard(int id) async {
    try {
      // In local implementation, we just return success
      // In a real implementation, this would delete from local storage
      _log.fine('Deleted flashcard with id: $id');
      return Result.ok(null);
    } on Exception catch (error) {
      _log.warning('Failed to delete flashcard', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<Flashcard>>> getFlashcardsByIds(List<int> ids) async {
    try {
      final allFlashcards = await _localDataService.getFlashcards();
      final flashcards = allFlashcards.where((card) => ids.contains(card.flashcardId)).toList();
      _log.fine('Loaded ${flashcards.length} flashcards by IDs');
      return Result.ok(flashcards);
    } on Exception catch (error) {
      _log.warning('Failed to get flashcards by IDs', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<Flashcard>>> searchFlashcards(String query) async {
    try {
      final flashcards = await _localDataService.getFlashcards();
      final searchResults = flashcards.where((card) {
        final wordLower = card.word.word.toLowerCase();
        final queryLower = query.toLowerCase();
        
        // Search in word
        if (wordLower.contains(queryLower)) return true;
        
        // Search in meanings
        for (final meaning in card.meanings) {
          if (meaning.translation.toLowerCase().contains(queryLower)) return true;
        }
        
        return false;
      }).toList();
      _log.fine('Found ${searchResults.length} flashcards matching "$query"');
      return Result.ok(searchResults);
    } on Exception catch (error) {
      _log.warning('Failed to search flashcards', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<Flashcard>>> getFlashcardsForReview() async {
    try {
      final flashcards = await _localDataService.getFlashcards();
      // In a real implementation, this would filter based on spaced repetition algorithm
      // For now, we'll return all non-checked flashcards
      final reviewCards = flashcards.where((card) => !card.checkFlag).toList();
      _log.fine('Found ${reviewCards.length} flashcards for review');
      return Result.ok(reviewCards);
    } on Exception catch (error) {
      _log.warning('Failed to get flashcards for review', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Flashcard>> updateFlashcardMemo(int id, String memo) async {
    try {
      final flashcard = await _localDataService.getFlashcardById(id);
      if (flashcard == null) {
        return Result.error(Exception('Flashcard not found with id: $id'));
      }
      final updated = flashcard.copyWith(memo: memo);
      _log.fine('Updated memo for flashcard: ${flashcard.word.word}');
      return Result.ok(updated);
    } on Exception catch (error) {
      _log.warning('Failed to update flashcard memo', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Flashcard>> updateFlashcardCheckFlag(int id, bool checkFlag) async {
    try {
      final flashcard = await _localDataService.getFlashcardById(id);
      if (flashcard == null) {
        return Result.error(Exception('Flashcard not found with id: $id'));
      }
      final updated = flashcard.copyWith(checkFlag: checkFlag);
      _log.fine('Updated check flag for flashcard: ${flashcard.word.word}');
      return Result.ok(updated);
    } on Exception catch (error) {
      _log.warning('Failed to update flashcard check flag', error);
      return Result.error(error);
    }
  }
}