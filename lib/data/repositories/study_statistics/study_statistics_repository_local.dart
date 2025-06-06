import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/study_statistics/mastery_level.dart';
import '../../../domain/models/study_statistics/study_statistics.dart';
import '../../services/local_data_service.dart';
import 'study_statistics_repository.dart';

/// Local implementation of StudyStatisticsRepository using JSON data
class StudyStatisticsRepositoryLocal implements StudyStatisticsRepository {
  StudyStatisticsRepositoryLocal({
    required LocalDataService localDataService,
  }) : _localDataService = localDataService;

  final LocalDataService _localDataService;
  final _log = Logger('StudyStatisticsRepositoryLocal');

  @override
  Future<Result<StudyStatistics>> getStudyStatistics(String userId) async {
    try {
      final statistics = await _localDataService.getStudyStatisticsByUserId(userId);
      if (statistics == null) {
        return Result.error(Exception('Study statistics not found for user: $userId'));
      }
      _log.fine('Loaded study statistics for user: $userId');
      return Result.ok(statistics);
    } on Exception catch (error) {
      _log.warning('Failed to get study statistics', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<StudyStatistics>> createStudyStatistics(StudyStatistics statistics) async {
    try {
      // In local implementation, we just return the statistics as created
      // In a real implementation, this would save to local storage
      _log.fine('Created study statistics for user: ${statistics.userId}');
      return Result.ok(statistics);
    } on Exception catch (error) {
      _log.warning('Failed to create study statistics', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<StudyStatistics>> updateStudyStatistics(StudyStatistics statistics) async {
    try {
      // In local implementation, we just return the updated statistics
      // In a real implementation, this would update local storage
      _log.fine('Updated study statistics for user: ${statistics.userId}');
      return Result.ok(statistics);
    } on Exception catch (error) {
      _log.warning('Failed to update study statistics', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<StudyStatistics>> incrementStudyCounters(
    String userId,
    int cardsStudied,
    int studyTimeSeconds,
  ) async {
    try {
      final statistics = await _localDataService.getStudyStatisticsByUserId(userId);
      if (statistics == null) {
        return Result.error(Exception('Study statistics not found for user: $userId'));
      }
      
      final updated = statistics.copyWith(
        totalCardsStudied: statistics.totalCardsStudied + cardsStudied,
        totalStudyTimeSeconds: statistics.totalStudyTimeSeconds + studyTimeSeconds,
        lastUpdated: DateTime.now(),
      );
      
      _log.fine('Incremented study counters for user: $userId');
      return Result.ok(updated);
    } on Exception catch (error) {
      _log.warning('Failed to increment study counters', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<StudyStatistics>> updateMasteryDistribution(
    String userId,
    Map<MasteryLevel, int> distribution,
  ) async {
    try {
      final statistics = await _localDataService.getStudyStatisticsByUserId(userId);
      if (statistics == null) {
        return Result.error(Exception('Study statistics not found for user: $userId'));
      }
      
      final updated = statistics.copyWith(
        masteryDistribution: distribution,
        lastUpdated: DateTime.now(),
      );
      
      _log.fine('Updated mastery distribution for user: $userId');
      return Result.ok(updated);
    } on Exception catch (error) {
      _log.warning('Failed to update mastery distribution', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<StudyStatistics>> updateStreak(
    String userId,
    int currentStreak,
    DateTime lastStudyDate,
  ) async {
    try {
      final statistics = await _localDataService.getStudyStatisticsByUserId(userId);
      if (statistics == null) {
        return Result.error(Exception('Study statistics not found for user: $userId'));
      }
      
      final longestStreak = currentStreak > statistics.longestStreak 
          ? currentStreak 
          : statistics.longestStreak;
      
      final updated = statistics.copyWith(
        currentStreak: currentStreak,
        longestStreak: longestStreak,
        lastStudyDate: lastStudyDate,
        lastUpdated: DateTime.now(),
      );
      
      _log.fine('Updated streak for user: $userId (current: $currentStreak)');
      return Result.ok(updated);
    } on Exception catch (error) {
      _log.warning('Failed to update streak', error);
      return Result.error(error);
    }
  }
}