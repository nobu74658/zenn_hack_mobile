import 'package:result_dart/result_dart.dart';

import '../../../domain/models/learning_record/learning_action.dart';
import '../../../domain/models/learning_record/learning_record.dart';

/// Abstract repository interface for LearningRecord entity
abstract class LearningRecordRepository {
  /// Gets all learning records
  Future<Result<List<LearningRecord>>> getLearningRecords();

  /// Gets a single learning record by ID
  Future<Result<LearningRecord>> getLearningRecord(int id);

  /// Gets learning records for a specific user
  Future<Result<List<LearningRecord>>> getLearningRecordsByUserId(String userId);

  /// Gets learning records for a specific flashcard
  Future<Result<List<LearningRecord>>> getLearningRecordsByFlashcardId(int flashcardId);

  /// Creates a new learning record
  Future<Result<LearningRecord>> createLearningRecord(LearningRecord record);

  /// Gets learning records within a date range
  Future<Result<List<LearningRecord>>> getLearningRecordsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Gets learning records by action type
  Future<Result<List<LearningRecord>>> getLearningRecordsByAction(
    String userId,
    LearningAction action,
  );

  /// Records a learning action
  Future<Result<LearningRecord>> recordAction(
    int flashcardId,
    String userId,
    LearningAction action,
    int durationSeconds,
    Map<String, dynamic>? context,
  );
}