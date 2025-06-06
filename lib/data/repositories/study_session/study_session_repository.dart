import 'package:result_dart/result_dart.dart';

import '../../../domain/models/study_session/study_session.dart';

/// Abstract repository interface for StudySession entity
abstract class StudySessionRepository {
  /// Gets all study sessions
  Future<Result<List<StudySession>>> getStudySessions();

  /// Gets a single study session by ID
  Future<Result<StudySession>> getStudySession(int id);

  /// Gets study sessions for a specific user
  Future<Result<List<StudySession>>> getStudySessionsByUserId(String userId);

  /// Creates a new study session
  Future<Result<StudySession>> createStudySession(StudySession session);

  /// Updates an existing study session
  Future<Result<StudySession>> updateStudySession(StudySession session);

  /// Deletes a study session by ID
  Future<Result<void>> deleteStudySession(int id);

  /// Gets study sessions within a date range
  Future<Result<List<StudySession>>> getStudySessionsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Completes a study session
  Future<Result<StudySession>> completeStudySession(
    int sessionId,
    DateTime endTime,
    int cardsMastered,
    int cardsNeedsPractice,
    int cardsSkipped,
  );
}