import 'package:result_dart/result_dart.dart';

import '../../../domain/models/study_statistics/mastery_level.dart';
import '../../../domain/models/study_statistics/study_statistics.dart';

/// Abstract repository interface for StudyStatistics entity
abstract class StudyStatisticsRepository {
  /// Gets study statistics for a user
  Future<Result<StudyStatistics>> getStudyStatistics(String userId);

  /// Creates new study statistics for a user
  Future<Result<StudyStatistics>> createStudyStatistics(StudyStatistics statistics);

  /// Updates existing study statistics
  Future<Result<StudyStatistics>> updateStudyStatistics(StudyStatistics statistics);

  /// Increments study counters
  Future<Result<StudyStatistics>> incrementStudyCounters(
    String userId,
    int cardsStudied,
    int studyTimeSeconds,
  );

  /// Updates mastery distribution
  Future<Result<StudyStatistics>> updateMasteryDistribution(
    String userId,
    Map<MasteryLevel, int> distribution,
  );

  /// Updates streak information
  Future<Result<StudyStatistics>> updateStreak(
    String userId,
    int currentStreak,
    DateTime lastStudyDate,
  );
}