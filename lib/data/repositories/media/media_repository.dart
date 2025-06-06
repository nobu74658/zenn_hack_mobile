import 'package:result_dart/result_dart.dart';

import '../../../domain/models/media/media.dart';

/// Abstract repository interface for Media entity
abstract class MediaRepository {
  /// Gets all media
  Future<Result<List<Media>>> getMedia();

  /// Gets a single media by ID
  Future<Result<Media>> getMediaById(int id);

  /// Gets media for a specific meaning
  Future<Result<List<Media>>> getMediaByMeaningId(int meaningId);

  /// Creates new media
  Future<Result<Media>> createMedia(Media media);

  /// Updates existing media
  Future<Result<Media>> updateMedia(Media media);

  /// Deletes media by ID
  Future<Result<void>> deleteMedia(int id);

  /// Uploads media files and returns URLs
  Future<Result<List<String>>> uploadMediaFiles(List<String> filePaths);
}