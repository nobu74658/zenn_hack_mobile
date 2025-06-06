import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/media/media.dart';
import '../../services/local_data_service.dart';
import 'media_repository.dart';

/// Local implementation of MediaRepository using JSON data
class MediaRepositoryLocal implements MediaRepository {
  MediaRepositoryLocal({
    required LocalDataService localDataService,
  }) : _localDataService = localDataService;

  final LocalDataService _localDataService;
  final _log = Logger('MediaRepositoryLocal');

  @override
  Future<Result<List<Media>>> getMedia() async {
    try {
      final media = await _localDataService.getMedia();
      _log.fine('Loaded ${media.length} media items');
      return Result.ok(media);
    } on Exception catch (error) {
      _log.warning('Failed to get media', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Media>> getMediaById(int id) async {
    try {
      final mediaList = await _localDataService.getMedia();
      final media = mediaList.where((m) => m.mediaId == id).firstOrNull;
      if (media == null) {
        return Result.error(Exception('Media not found with id: $id'));
      }
      _log.fine('Loaded media with id: $id');
      return Result.ok(media);
    } on Exception catch (error) {
      _log.warning('Failed to get media by id', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<Media>>> getMediaByMeaningId(int meaningId) async {
    try {
      final media = await _localDataService.getMediaByMeaningId(meaningId);
      _log.fine('Loaded ${media.length} media items for meaning $meaningId');
      return Result.ok(media);
    } on Exception catch (error) {
      _log.warning('Failed to get media by meaning ID', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Media>> createMedia(Media media) async {
    try {
      // In local implementation, we just return the media as created
      // In a real implementation, this would save to local storage
      _log.fine('Created media for meaning: ${media.meaningId}');
      return Result.ok(media);
    } on Exception catch (error) {
      _log.warning('Failed to create media', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Media>> updateMedia(Media media) async {
    try {
      // In local implementation, we just return the updated media
      // In a real implementation, this would update local storage
      _log.fine('Updated media: ${media.mediaId}');
      return Result.ok(media);
    } on Exception catch (error) {
      _log.warning('Failed to update media', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> deleteMedia(int id) async {
    try {
      // In local implementation, we just return success
      // In a real implementation, this would delete from local storage
      _log.fine('Deleted media with id: $id');
      return Result.ok(null);
    } on Exception catch (error) {
      _log.warning('Failed to delete media', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<String>>> uploadMediaFiles(List<String> filePaths) async {
    try {
      // In local implementation, we simulate upload by returning the file paths as URLs
      // In a real implementation, this would upload to cloud storage
      _log.fine('Uploaded ${filePaths.length} media files');
      return Result.ok(filePaths);
    } on Exception catch (error) {
      _log.warning('Failed to upload media files', error);
      return Result.error(error);
    }
  }
}