import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_session.freezed.dart';
part 'study_session.g.dart';

/// Represents a single study session with multiple flashcards
@freezed
class StudySession with _$StudySession {
  const factory StudySession({
    /// Primary key identifier for the study session
    required String sessionId,
    
    /// User identifier who conducted the session
    required String userId,
    
    /// Session start timestamp
    required DateTime startTime,
    
    /// Session end timestamp (null if ongoing)
    DateTime? endTime,
    
    /// List of flashcard IDs studied in this session
    required List<String> flashcardIds,
    
    /// Number of cards marked as mastered in this session
    required int cardsMastered,
    
    /// Number of cards marked as needs practice
    required int cardsNeedsPractice,
    
    /// Number of cards skipped
    required int cardsSkipped,
    
    /// Total duration of the session in seconds
    int? durationSeconds,
    
    /// Session completion status
    required bool isCompleted,
  }) = _StudySession;

  factory StudySession.fromJson(Map<String, Object?> json) => _$StudySessionFromJson(json);
}