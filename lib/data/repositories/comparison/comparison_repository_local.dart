import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/comparison/comparison.dart';
import '../../services/local_data_service.dart';
import 'comparison_repository.dart';

/// Local implementation of ComparisonRepository using JSON data
class ComparisonRepositoryLocal implements ComparisonRepository {
  ComparisonRepositoryLocal({
    required LocalDataService localDataService,
  }) : _localDataService = localDataService;

  final LocalDataService _localDataService;
  final _log = Logger('ComparisonRepositoryLocal');

  @override
  Future<Result<List<Comparison>>> getComparisons() async {
    try {
      final comparisons = await _localDataService.getComparisons();
      _log.fine('Loaded ${comparisons.length} comparisons');
      return Result.ok(comparisons);
    } on Exception catch (error) {
      _log.warning('Failed to get comparisons', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Comparison>> getComparison(int id) async {
    try {
      final comparisons = await _localDataService.getComparisons();
      final comparison = comparisons.where((c) => c.comparisonId == id).firstOrNull;
      if (comparison == null) {
        return Result.error(Exception('Comparison not found with id: $id'));
      }
      _log.fine('Loaded comparison with id: $id');
      return Result.ok(comparison);
    } on Exception catch (error) {
      _log.warning('Failed to get comparison', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<Comparison>>> getComparisonsByMediaIds(List<int> mediaIds) async {
    try {
      final comparisons = await _localDataService.getComparisonsByMediaIds(mediaIds);
      _log.fine('Loaded ${comparisons.length} comparisons for media IDs');
      return Result.ok(comparisons);
    } on Exception catch (error) {
      _log.warning('Failed to get comparisons by media IDs', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Comparison>> createComparison(Comparison comparison) async {
    try {
      // In local implementation, we just return the comparison as created
      // In a real implementation, this would save to local storage
      _log.fine('Created comparison between media ${comparison.oldMediaId} and ${comparison.newMediaId}');
      return Result.ok(comparison);
    } on Exception catch (error) {
      _log.warning('Failed to create comparison', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Comparison>> updateComparison(Comparison comparison) async {
    try {
      // In local implementation, we just return the updated comparison
      // In a real implementation, this would update local storage
      _log.fine('Updated comparison: ${comparison.comparisonId}');
      return Result.ok(comparison);
    } on Exception catch (error) {
      _log.warning('Failed to update comparison', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> deleteComparison(int id) async {
    try {
      // In local implementation, we just return success
      // In a real implementation, this would delete from local storage
      _log.fine('Deleted comparison with id: $id');
      return Result.ok(null);
    } on Exception catch (error) {
      _log.warning('Failed to delete comparison', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Comparison>> updateComparisonSelection(int id, String selected) async {
    try {
      final comparisons = await _localDataService.getComparisons();
      final comparison = comparisons.where((c) => c.comparisonId == id).firstOrNull;
      if (comparison == null) {
        return Result.error(Exception('Comparison not found with id: $id'));
      }
      final updated = comparison.copyWith(selected: selected);
      _log.fine('Updated comparison selection: $selected');
      return Result.ok(updated);
    } on Exception catch (error) {
      _log.warning('Failed to update comparison selection', error);
      return Result.error(error);
    }
  }
}