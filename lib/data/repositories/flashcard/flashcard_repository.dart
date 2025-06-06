import 'package:result_dart/result_dart.dart';

import '../../../domain/models/flashcard/flashcard.dart';

/// Abstract repository interface for Flashcard entity
abstract class FlashcardRepository {
  /// Gets all flashcards
  Future<Result<List<Flashcard>>> getFlashcards();

  /// Gets a single flashcard by ID
  Future<Result<Flashcard>> getFlashcard(int id);

  /// Creates a new flashcard
  Future<Result<Flashcard>> createFlashcard(Flashcard flashcard);

  /// Updates an existing flashcard
  Future<Result<Flashcard>> updateFlashcard(Flashcard flashcard);

  /// Deletes a flashcard by ID
  Future<Result<void>> deleteFlashcard(int id);

  /// Gets flashcards by IDs
  Future<Result<List<Flashcard>>> getFlashcardsByIds(List<int> ids);

  /// Searches flashcards by word or translation
  Future<Result<List<Flashcard>>> searchFlashcards(String query);

  /// Gets flashcards that need review
  Future<Result<List<Flashcard>>> getFlashcardsForReview();

  /// Updates flashcard memo
  Future<Result<Flashcard>> updateFlashcardMemo(int id, String memo);

  /// Updates flashcard check flag
  Future<Result<Flashcard>> updateFlashcardCheckFlag(int id, bool checkFlag);
}