import 'package:result_dart/result_dart.dart';

import '../../../domain/models/meaning/meaning.dart';

/// Abstract repository interface for Meaning entity
abstract class MeaningRepository {
  /// Gets all meanings
  Future<Result<List<Meaning>>> getMeanings();

  /// Gets a single meaning by ID
  Future<Result<Meaning>> getMeaning(int id);

  /// Gets meanings for a specific word
  Future<Result<List<Meaning>>> getMeaningsByWordId(int wordId);

  /// Creates a new meaning
  Future<Result<Meaning>> createMeaning(Meaning meaning);

  /// Updates an existing meaning
  Future<Result<Meaning>> updateMeaning(Meaning meaning);

  /// Deletes a meaning by ID
  Future<Result<void>> deleteMeaning(int id);
}