import 'package:result_dart/result_dart.dart';

import '../../../domain/models/comparison/comparison.dart';

/// Abstract repository interface for Comparison entity
abstract class ComparisonRepository {
  /// Gets all comparisons
  Future<Result<List<Comparison>>> getComparisons();

  /// Gets a single comparison by ID
  Future<Result<Comparison>> getComparison(int id);

  /// Gets comparisons by media IDs
  Future<Result<List<Comparison>>> getComparisonsByMediaIds(List<int> mediaIds);

  /// Creates a new comparison
  Future<Result<Comparison>> createComparison(Comparison comparison);

  /// Updates an existing comparison
  Future<Result<Comparison>> updateComparison(Comparison comparison);

  /// Deletes a comparison by ID
  Future<Result<void>> deleteComparison(int id);

  /// Updates comparison selection
  Future<Result<Comparison>> updateComparisonSelection(int id, String selected);
}