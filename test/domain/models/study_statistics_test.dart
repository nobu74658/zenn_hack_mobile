import 'package:flutter_test/flutter_test.dart';

import '../../../lib/domain/models/study_statistics/mastery_level.dart';
import '../../../lib/domain/models/study_statistics/study_statistics.dart';

void main() {
  group('StudyStatistics', () {
    test('should create StudyStatistics instance with all required fields', () {
      // Arrange
      final lastStudyDate = DateTime(2024, 1, 1);
      final lastUpdated = DateTime(2024, 1, 1, 12, 0);
      final masteryDistribution = {
        MasteryLevel.beginner: 10,
        MasteryLevel.learning: 20,
        MasteryLevel.intermediate: 15,
        MasteryLevel.advanced: 5,
        MasteryLevel.mastered: 2,
      };

      // Act
      final stats = StudyStatistics(
        statisticsId: 'stats_001',
        userId: 'user_001',
        totalCardsStudied: 100,
        uniqueCardsStudied: 52,
        totalStudyTimeSeconds: 3600,
        masteryDistribution: masteryDistribution,
        currentStreak: 5,
        longestStreak: 15,
        lastStudyDate: lastStudyDate,
        lastUpdated: lastUpdated,
      );

      // Assert
      expect(stats.statisticsId, 'stats_001');
      expect(stats.userId, 'user_001');
      expect(stats.totalCardsStudied, 100);
      expect(stats.uniqueCardsStudied, 52);
      expect(stats.totalStudyTimeSeconds, 3600);
      expect(stats.masteryDistribution[MasteryLevel.beginner], 10);
      expect(stats.masteryDistribution[MasteryLevel.mastered], 2);
      expect(stats.currentStreak, 5);
      expect(stats.longestStreak, 15);
      expect(stats.lastStudyDate, lastStudyDate);
      expect(stats.lastUpdated, lastUpdated);
    });

    test('should support all MasteryLevel enum values', () {
      // Assert
      expect(MasteryLevel.values.length, 5);
      expect(MasteryLevel.values, contains(MasteryLevel.beginner));
      expect(MasteryLevel.values, contains(MasteryLevel.learning));
      expect(MasteryLevel.values, contains(MasteryLevel.intermediate));
      expect(MasteryLevel.values, contains(MasteryLevel.advanced));
      expect(MasteryLevel.values, contains(MasteryLevel.mastered));
    });
  });
}