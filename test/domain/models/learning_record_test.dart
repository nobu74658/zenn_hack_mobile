import 'package:flutter_test/flutter_test.dart';

import '../../../lib/domain/models/learning_record/learning_action.dart';
import '../../../lib/domain/models/learning_record/learning_record.dart';

void main() {
  group('LearningRecord', () {
    test('should create LearningRecord instance with all required fields', () {
      // Arrange
      final timestamp = DateTime(2024, 1, 1, 10, 30);

      // Act
      final record = LearningRecord(
        recordId: 'record_001',
        flashcardId: 'flashcard_001',
        userId: 'user_001',
        action: LearningAction.viewed,
        timestamp: timestamp,
        durationSeconds: 30,
        context: 'First view',
      );

      // Assert
      expect(record.recordId, 'record_001');
      expect(record.flashcardId, 'flashcard_001');
      expect(record.userId, 'user_001');
      expect(record.action, LearningAction.viewed);
      expect(record.timestamp, timestamp);
      expect(record.durationSeconds, 30);
      expect(record.context, 'First view');
    });

    test('should handle null context', () {
      // Arrange & Act
      final record = LearningRecord(
        recordId: 'record_002',
        flashcardId: 'flashcard_002',
        userId: 'user_001',
        action: LearningAction.mastered,
        timestamp: DateTime.now(),
        durationSeconds: 45,
        context: null,
      );

      // Assert
      expect(record.context, isNull);
    });

    test('should support all LearningAction enum values', () {
      // Assert
      expect(LearningAction.values.length, 5);
      expect(LearningAction.values, contains(LearningAction.viewed));
      expect(LearningAction.values, contains(LearningAction.mastered));
      expect(LearningAction.values, contains(LearningAction.needsPractice));
      expect(LearningAction.values, contains(LearningAction.skipped));
      expect(LearningAction.values, contains(LearningAction.memoUpdated));
    });
  });
}