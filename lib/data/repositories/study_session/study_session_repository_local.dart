import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/study_session/study_session.dart';
import '../../services/local_data_service.dart';
import 'study_session_repository.dart';

/// Local implementation of StudySessionRepository using JSON data
class StudySessionRepositoryLocal implements StudySessionRepository {
  StudySessionRepositoryLocal({
    required LocalDataService localDataService,
  }) : _localDataService = localDataService;

  final LocalDataService _localDataService;
  final _log = Logger('StudySessionRepositoryLocal');

  @override
  Future<Result<List<StudySession>>> getStudySessions() async {
    try {
      final sessions = await _localDataService.getStudySessions();
      _log.fine('Loaded ${sessions.length} study sessions');
      return Result.ok(sessions);
    } on Exception catch (error) {
      _log.warning('Failed to get study sessions', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<StudySession>> getStudySession(int id) async {
    try {
      final sessions = await _localDataService.getStudySessions();
      final session = sessions.where((s) => s.sessionId == id).firstOrNull;
      if (session == null) {
        return Result.error(Exception('Study session not found with id: $id'));
      }
      _log.fine('Loaded study session: $id');
      return Result.ok(session);
    } on Exception catch (error) {
      _log.warning('Failed to get study session', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<StudySession>>> getStudySessionsByUserId(String userId) async {
    try {
      final sessions = await _localDataService.getStudySessionsByUserId(userId);
      _log.fine('Loaded ${sessions.length} study sessions for user: $userId');
      return Result.ok(sessions);
    } on Exception catch (error) {
      _log.warning('Failed to get study sessions by user ID', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<StudySession>> createStudySession(StudySession session) async {
    try {
      // In local implementation, we just return the session as created
      // In a real implementation, this would save to local storage
      _log.fine('Created study session for user: ${session.userId}');
      return Result.ok(session);
    } on Exception catch (error) {
      _log.warning('Failed to create study session', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<StudySession>> updateStudySession(StudySession session) async {
    try {
      // In local implementation, we just return the updated session
      // In a real implementation, this would update local storage
      _log.fine('Updated study session: ${session.sessionId}');
      return Result.ok(session);
    } on Exception catch (error) {
      _log.warning('Failed to update study session', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> deleteStudySession(int id) async {
    try {
      // In local implementation, we just return success
      // In a real implementation, this would delete from local storage
      _log.fine('Deleted study session with id: $id');
      return Result.ok(null);
    } on Exception catch (error) {
      _log.warning('Failed to delete study session', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<StudySession>>> getStudySessionsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final sessions = await _localDataService.getStudySessionsByUserId(userId);
      final filtered = sessions.where((session) {
        return session.startTime.isAfter(startDate) && 
               session.startTime.isBefore(endDate);
      }).toList();
      _log.fine('Found ${filtered.length} sessions in date range');
      return Result.ok(filtered);
    } on Exception catch (error) {
      _log.warning('Failed to get study sessions by date range', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<StudySession>> completeStudySession(
    int sessionId,
    DateTime endTime,
    int cardsMastered,
    int cardsNeedsPractice,
    int cardsSkipped,
  ) async {
    try {
      final sessions = await _localDataService.getStudySessions();
      final session = sessions.where((s) => s.sessionId == sessionId).firstOrNull;
      if (session == null) {
        return Result.error(Exception('Study session not found with id: $sessionId'));
      }
      
      final durationSeconds = endTime.difference(session.startTime).inSeconds;
      final completed = session.copyWith(
        endTime: endTime,
        cardsMastered: cardsMastered,
        cardsNeedsPractice: cardsNeedsPractice,
        cardsSkipped: cardsSkipped,
        durationSeconds: durationSeconds,
        isCompleted: true,
      );
      
      _log.fine('Completed study session: $sessionId');
      return Result.ok(completed);
    } on Exception catch (error) {
      _log.warning('Failed to complete study session', error);
      return Result.error(error);
    }
  }
}