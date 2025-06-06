import 'package:flutter_test/flutter_test.dart';

import '../../../lib/domain/models/study_session/study_session.dart';

void main() {
  group('StudySession', () {
    test('should create StudySession instance with all required fields', () {
      // Arrange
      final startTime = DateTime(2024, 1, 1, 10, 0);
      final endTime = DateTime(2024, 1, 1, 10, 30);

      // Act
      final session = StudySession(
        sessionId: 'session_001',
        userId: 'user_001',
        startTime: startTime,
        endTime: endTime,
        flashcardIds: ['flashcard_001', 'flashcard_002', 'flashcard_003'],
        cardsMastered: 2,
        cardsNeedsPractice: 1,
        cardsSkipped: 0,
        durationSeconds: 1800,
        isCompleted: true,
      );

      // Assert
      expect(session.sessionId, 'session_001');
      expect(session.userId, 'user_001');
      expect(session.startTime, startTime);
      expect(session.endTime, endTime);
      expect(session.flashcardIds.length, 3);
      expect(session.cardsMastered, 2);
      expect(session.cardsNeedsPractice, 1);
      expect(session.cardsSkipped, 0);
      expect(session.durationSeconds, 1800);
      expect(session.isCompleted, true);
    });

    test('should handle ongoing session with null endTime', () {
      // Arrange
      final startTime = DateTime.now();

      // Act
      final session = StudySession(
        sessionId: 'session_002',
        userId: 'user_001',
        startTime: startTime,
        endTime: null,
        flashcardIds: ['flashcard_001'],
        cardsMastered: 0,
        cardsNeedsPractice: 0,
        cardsSkipped: 0,
        durationSeconds: null,
        isCompleted: false,
      );

      // Assert
      expect(session.endTime, isNull);
      expect(session.durationSeconds, isNull);
      expect(session.isCompleted, false);
    });
  });
}