import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/comparison/comparison_repository.dart';
import '../repositories/comparison/comparison_repository_local.dart';
import '../repositories/flashcard/flashcard_repository.dart';
import '../repositories/flashcard/flashcard_repository_local.dart';
import '../repositories/learning_record/learning_record_repository.dart';
import '../repositories/learning_record/learning_record_repository_local.dart';
import '../repositories/meaning/meaning_repository.dart';
import '../repositories/meaning/meaning_repository_local.dart';
import '../repositories/media/media_repository.dart';
import '../repositories/media/media_repository_local.dart';
import '../repositories/study_session/study_session_repository.dart';
import '../repositories/study_session/study_session_repository_local.dart';
import '../repositories/study_statistics/study_statistics_repository.dart';
import '../repositories/study_statistics/study_statistics_repository_local.dart';
import '../repositories/template/template_repository.dart';
import '../repositories/template/template_repository_local.dart';
import '../repositories/word/word_repository.dart';
import '../repositories/word/word_repository_local.dart';
import '../services/local_data_service.dart';

part 'repository_providers.g.dart';

/// Provider for LocalDataService
@riverpod
LocalDataService localDataService(LocalDataServiceRef ref) {
  return LocalDataService();
}

/// Provider for WordRepository
@riverpod
WordRepository wordRepository(WordRepositoryRef ref) {
  final dataService = ref.watch(localDataServiceProvider);
  return WordRepositoryLocal(localDataService: dataService);
}

/// Provider for MeaningRepository
@riverpod
MeaningRepository meaningRepository(MeaningRepositoryRef ref) {
  final dataService = ref.watch(localDataServiceProvider);
  return MeaningRepositoryLocal(localDataService: dataService);
}

/// Provider for MediaRepository
@riverpod
MediaRepository mediaRepository(MediaRepositoryRef ref) {
  final dataService = ref.watch(localDataServiceProvider);
  return MediaRepositoryLocal(localDataService: dataService);
}

/// Provider for FlashcardRepository
@riverpod
FlashcardRepository flashcardRepository(FlashcardRepositoryRef ref) {
  final dataService = ref.watch(localDataServiceProvider);
  return FlashcardRepositoryLocal(localDataService: dataService);
}

/// Provider for TemplateRepository
@riverpod
TemplateRepository templateRepository(TemplateRepositoryRef ref) {
  final dataService = ref.watch(localDataServiceProvider);
  return TemplateRepositoryLocal(localDataService: dataService);
}

/// Provider for ComparisonRepository
@riverpod
ComparisonRepository comparisonRepository(ComparisonRepositoryRef ref) {
  final dataService = ref.watch(localDataServiceProvider);
  return ComparisonRepositoryLocal(localDataService: dataService);
}

/// Provider for StudySessionRepository
@riverpod
StudySessionRepository studySessionRepository(StudySessionRepositoryRef ref) {
  final dataService = ref.watch(localDataServiceProvider);
  return StudySessionRepositoryLocal(localDataService: dataService);
}

/// Provider for StudyStatisticsRepository
@riverpod
StudyStatisticsRepository studyStatisticsRepository(StudyStatisticsRepositoryRef ref) {
  final dataService = ref.watch(localDataServiceProvider);
  return StudyStatisticsRepositoryLocal(localDataService: dataService);
}

/// Provider for LearningRecordRepository
@riverpod
LearningRecordRepository learningRecordRepository(LearningRecordRepositoryRef ref) {
  final dataService = ref.watch(localDataServiceProvider);
  return LearningRecordRepositoryLocal(localDataService: dataService);
}