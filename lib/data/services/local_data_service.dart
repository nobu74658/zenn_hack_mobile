import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import '../../domain/models/comparison/comparison.dart';
import '../../domain/models/flashcard/flashcard.dart';
import '../../domain/models/learning_record/learning_record.dart';
import '../../domain/models/meaning/meaning.dart';
import '../../domain/models/media/media.dart';
import '../../domain/models/study_session/study_session.dart';
import '../../domain/models/study_statistics/study_statistics.dart';
import '../../domain/models/template/template.dart';
import '../../domain/models/word/word.dart';

/// Service for loading local JSON data from assets
class LocalDataService {
  LocalDataService();

  final _log = Logger('LocalDataService');

  /// Loads and parses JSON data from a file in the assets directory
  Future<T> _loadJsonData<T>(
    String fileName,
    T Function(List<dynamic>) parser,
  ) async {
    try {
      final jsonString = await rootBundle.loadString('assets/$fileName');
      final jsonData = json.decode(jsonString) as List<dynamic>;
      return parser(jsonData);
    } catch (error) {
      _log.severe('Failed to load $fileName', error);
      rethrow;
    }
  }

  /// Loads all words from local JSON
  Future<List<Word>> getWords() async {
    return _loadJsonData(
      'words.json',
      (data) => data.map((json) => Word.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }

  /// Loads all meanings from local JSON
  Future<List<Meaning>> getMeanings() async {
    return _loadJsonData(
      'meanings.json',
      (data) => data.map((json) => Meaning.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }

  /// Loads all media from local JSON
  Future<List<Media>> getMedia() async {
    return _loadJsonData(
      'media.json',
      (data) => data.map((json) => Media.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }

  /// Loads all flashcards from local JSON
  Future<List<Flashcard>> getFlashcards() async {
    return _loadJsonData(
      'flashcards.json',
      (data) => data.map((json) => Flashcard.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }

  /// Loads all templates from local JSON
  Future<List<Template>> getTemplates() async {
    return _loadJsonData(
      'templates.json',
      (data) => data.map((json) => Template.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }

  /// Loads all comparisons from local JSON
  Future<List<Comparison>> getComparisons() async {
    return _loadJsonData(
      'comparisons.json',
      (data) => data.map((json) => Comparison.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }

  /// Loads all study sessions from local JSON
  Future<List<StudySession>> getStudySessions() async {
    return _loadJsonData(
      'study_sessions.json',
      (data) => data.map((json) => StudySession.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }

  /// Loads all study statistics from local JSON
  Future<List<StudyStatistics>> getStudyStatistics() async {
    return _loadJsonData(
      'study_statistics.json',
      (data) => data.map((json) => StudyStatistics.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }

  /// Loads all learning records from local JSON
  Future<List<LearningRecord>> getLearningRecords() async {
    return _loadJsonData(
      'learning_records.json',
      (data) => data.map((json) => LearningRecord.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }

  /// Get a single word by ID
  Future<Word?> getWordById(int id) async {
    final words = await getWords();
    return words.where((word) => word.wordId == id).firstOrNull;
  }

  /// Get meanings for a specific word
  Future<List<Meaning>> getMeaningsByWordId(int wordId) async {
    // In the actual implementation, meanings would be linked to words
    // For now, we'll need to filter based on some relationship
    final meanings = await getMeanings();
    // This is a placeholder - actual implementation would depend on data structure
    return meanings;
  }

  /// Get media for a specific meaning
  Future<List<Media>> getMediaByMeaningId(int meaningId) async {
    final media = await getMedia();
    return media.where((m) => m.meaningId == meaningId).toList();
  }

  /// Get a single flashcard by ID
  Future<Flashcard?> getFlashcardById(int id) async {
    final flashcards = await getFlashcards();
    return flashcards.where((card) => card.flashcardId == id).firstOrNull;
  }

  /// Get a single template by ID
  Future<Template?> getTemplateById(int id) async {
    final templates = await getTemplates();
    return templates.where((template) => template.templateId == id).firstOrNull;
  }

  /// Get comparisons for specific media IDs
  Future<List<Comparison>> getComparisonsByMediaIds(List<int> mediaIds) async {
    final comparisons = await getComparisons();
    return comparisons
        .where((comp) => mediaIds.contains(comp.oldMediaId) || mediaIds.contains(comp.newMediaId))
        .toList();
  }

  /// Get study sessions for a user
  Future<List<StudySession>> getStudySessionsByUserId(String userId) async {
    final sessions = await getStudySessions();
    return sessions.where((session) => session.userId == userId).toList();
  }

  /// Get study statistics for a user
  Future<StudyStatistics?> getStudyStatisticsByUserId(String userId) async {
    final statistics = await getStudyStatistics();
    return statistics.where((stats) => stats.userId == userId).firstOrNull;
  }

  /// Get learning records for a user
  Future<List<LearningRecord>> getLearningRecordsByUserId(String userId) async {
    final records = await getLearningRecords();
    return records.where((record) => record.userId == userId).toList();
  }
}