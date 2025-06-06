import 'package:freezed_annotation/freezed_annotation.dart';

import 'learning_action.dart';

part 'learning_record.freezed.dart';
part 'learning_record.g.dart';

/// Records individual learning activities for tracking progress
@freezed
class LearningRecord with _$LearningRecord {
  const factory LearningRecord({
    /// Primary key identifier for the learning record
    required String recordId,
    
    /// Reference to the flashcard being studied
    required String flashcardId,
    
    /// User identifier who performed the action
    required String userId,
    
    /// Type of learning action performed
    required LearningAction action,
    
    /// Timestamp when the action was performed
    required DateTime timestamp,
    
    /// Duration spent on this card (in seconds)
    required int durationSeconds,
    
    /// Additional context or data about the action
    String? context,
  }) = _LearningRecord;

  factory LearningRecord.fromJson(Map<String, Object?> json) => _$LearningRecordFromJson(json);
}