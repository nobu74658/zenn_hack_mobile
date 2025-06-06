import 'package:freezed_annotation/freezed_annotation.dart';

import 'mastery_level.dart';

part 'study_statistics.freezed.dart';
part 'study_statistics.g.dart';

/// Aggregated statistics for user's learning progress
@freezed
class StudyStatistics with _$StudyStatistics {
  const factory StudyStatistics({
    /// Primary key identifier for the statistics record
    required String statisticsId,
    
    /// User identifier for these statistics
    required String userId,
    
    /// Total number of flashcards studied
    required int totalCardsStudied,
    
    /// Number of unique flashcards studied
    required int uniqueCardsStudied,
    
    /// Total study time in seconds
    required int totalStudyTimeSeconds,
    
    /// Number of cards at each mastery level
    required Map<MasteryLevel, int> masteryDistribution,
    
    /// Current study streak in days
    required int currentStreak,
    
    /// Longest study streak achieved
    required int longestStreak,
    
    /// Last study session timestamp
    required DateTime lastStudyDate,
    
    /// Date when statistics were last updated
    required DateTime lastUpdated,
  }) = _StudyStatistics;

  factory StudyStatistics.fromJson(Map<String, Object?> json) => _$StudyStatisticsFromJson(json);
}