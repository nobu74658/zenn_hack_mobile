import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/learning_record/learning_action.dart';
import '../../../domain/models/learning_record/learning_record.dart';
import '../../services/local_data_service.dart';
import 'learning_record_repository.dart';

/// Local implementation of LearningRecordRepository using JSON data
class LearningRecordRepositoryLocal implements LearningRecordRepository {
  LearningRecordRepositoryLocal({
    required LocalDataService localDataService,
  }) : _localDataService = localDataService;

  final LocalDataService _localDataService;
  final _log = Logger('LearningRecordRepositoryLocal');

  @override
  Future<Result<List<LearningRecord>>> getLearningRecords() async {
    try {
      final records = await _localDataService.getLearningRecords();
      _log.fine('Loaded ${records.length} learning records');
      return Result.ok(records);
    } on Exception catch (error) {
      _log.warning('Failed to get learning records', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<LearningRecord>> getLearningRecord(int id) async {
    try {
      final records = await _localDataService.getLearningRecords();
      final record = records.where((r) => r.recordId == id).firstOrNull;
      if (record == null) {
        return Result.error(Exception('Learning record not found with id: $id'));
      }
      _log.fine('Loaded learning record: $id');
      return Result.ok(record);
    } on Exception catch (error) {
      _log.warning('Failed to get learning record', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<LearningRecord>>> getLearningRecordsByUserId(String userId) async {
    try {
      final records = await _localDataService.getLearningRecordsByUserId(userId);
      _log.fine('Loaded ${records.length} learning records for user: $userId');
      return Result.ok(records);
    } on Exception catch (error) {
      _log.warning('Failed to get learning records by user ID', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<LearningRecord>>> getLearningRecordsByFlashcardId(int flashcardId) async {
    try {
      final records = await _localDataService.getLearningRecords();
      final filtered = records.where((r) => r.flashcardId == flashcardId).toList();
      _log.fine('Loaded ${filtered.length} learning records for flashcard: $flashcardId');
      return Result.ok(filtered);
    } on Exception catch (error) {
      _log.warning('Failed to get learning records by flashcard ID', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<LearningRecord>> createLearningRecord(LearningRecord record) async {
    try {
      // In local implementation, we just return the record as created
      // In a real implementation, this would save to local storage
      _log.fine('Created learning record for flashcard: ${record.flashcardId}');
      return Result.ok(record);
    } on Exception catch (error) {
      _log.warning('Failed to create learning record', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<LearningRecord>>> getLearningRecordsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final records = await _localDataService.getLearningRecordsByUserId(userId);
      final filtered = records.where((record) {
        return record.timestamp.isAfter(startDate) && 
               record.timestamp.isBefore(endDate);
      }).toList();
      _log.fine('Found ${filtered.length} records in date range');
      return Result.ok(filtered);
    } on Exception catch (error) {
      _log.warning('Failed to get learning records by date range', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<LearningRecord>>> getLearningRecordsByAction(
    String userId,
    LearningAction action,
  ) async {
    try {
      final records = await _localDataService.getLearningRecordsByUserId(userId);
      final filtered = records.where((r) => r.action == action).toList();
      _log.fine('Found ${filtered.length} records with action: $action');
      return Result.ok(filtered);
    } on Exception catch (error) {
      _log.warning('Failed to get learning records by action', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<LearningRecord>> recordAction(
    int flashcardId,
    String userId,
    LearningAction action,
    int durationSeconds,
    Map<String, dynamic>? context,
  ) async {
    try {
      // Generate a new ID in a real implementation
      final recordId = DateTime.now().millisecondsSinceEpoch;
      
      final record = LearningRecord(
        recordId: recordId,
        flashcardId: flashcardId,
        userId: userId,
        action: action,
        timestamp: DateTime.now(),
        durationSeconds: durationSeconds,
        context: context,
      );
      
      _log.fine('Recorded action: $action for flashcard: $flashcardId');
      return Result.ok(record);
    } on Exception catch (error) {
      _log.warning('Failed to record action', error);
      return Result.error(error);
    }
  }
}