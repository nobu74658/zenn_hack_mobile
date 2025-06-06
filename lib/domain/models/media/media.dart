import 'package:freezed_annotation/freezed_annotation.dart';

part 'media.freezed.dart';
part 'media.g.dart';

/// Stores multimedia content associated with word meanings
@freezed
class Media with _$Media {
  const factory Media({
    /// Primary key identifier for the media
    required String mediaId,
    
    /// Foreign key reference to Meaning.meaningId
    required String meaningId,
    
    /// Array of media file URLs (images, audio, video)
    required List<String> mediaUrls,
  }) = _Media;

  factory Media.fromJson(Map<String, Object?> json) => _$MediaFromJson(json);
}