import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/meaning/meaning.dart';
import '../../services/local_data_service.dart';
import 'meaning_repository.dart';

/// Local implementation of MeaningRepository using JSON data
class MeaningRepositoryLocal implements MeaningRepository {
  MeaningRepositoryLocal({
    required LocalDataService localDataService,
  }) : _localDataService = localDataService;

  final LocalDataService _localDataService;
  final _log = Logger('MeaningRepositoryLocal');

  @override
  Future<Result<List<Meaning>>> getMeanings() async {
    try {
      final meanings = await _localDataService.getMeanings();
      _log.fine('Loaded ${meanings.length} meanings');
      return Result.ok(meanings);
    } on Exception catch (error) {
      _log.warning('Failed to get meanings', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Meaning>> getMeaning(int id) async {
    try {
      final meanings = await _localDataService.getMeanings();
      final meaning = meanings.where((m) => m.meaningId == id).firstOrNull;
      if (meaning == null) {
        return Result.error(Exception('Meaning not found with id: $id'));
      }
      _log.fine('Loaded meaning: ${meaning.translation}');
      return Result.ok(meaning);
    } on Exception catch (error) {
      _log.warning('Failed to get meaning', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<Meaning>>> getMeaningsByWordId(int wordId) async {
    try {
      final meanings = await _localDataService.getMeaningsByWordId(wordId);
      _log.fine('Loaded ${meanings.length} meanings for word $wordId');
      return Result.ok(meanings);
    } on Exception catch (error) {
      _log.warning('Failed to get meanings by word ID', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Meaning>> createMeaning(Meaning meaning) async {
    try {
      // In local implementation, we just return the meaning as created
      // In a real implementation, this would save to local storage
      _log.fine('Created meaning: ${meaning.translation}');
      return Result.ok(meaning);
    } on Exception catch (error) {
      _log.warning('Failed to create meaning', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Meaning>> updateMeaning(Meaning meaning) async {
    try {
      // In local implementation, we just return the updated meaning
      // In a real implementation, this would update local storage
      _log.fine('Updated meaning: ${meaning.translation}');
      return Result.ok(meaning);
    } on Exception catch (error) {
      _log.warning('Failed to update meaning', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> deleteMeaning(int id) async {
    try {
      // In local implementation, we just return success
      // In a real implementation, this would delete from local storage
      _log.fine('Deleted meaning with id: $id');
      return Result.ok(null);
    } on Exception catch (error) {
      _log.warning('Failed to delete meaning', error);
      return Result.error(error);
    }
  }
}