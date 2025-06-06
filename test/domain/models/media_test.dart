import 'package:flutter_test/flutter_test.dart';

import '../../../lib/domain/models/media/media.dart';

void main() {
  group('Media', () {
    test('should create Media instance with all required fields', () {
      // Arrange & Act
      const media = Media(
        mediaId: 'media_001',
        meaningId: 'meaning_001',
        mediaUrls: [
          'https://example.com/image1.jpg',
          'https://example.com/audio1.mp3',
        ],
      );

      // Assert
      expect(media.mediaId, 'media_001');
      expect(media.meaningId, 'meaning_001');
      expect(media.mediaUrls.length, 2);
      expect(media.mediaUrls[0], 'https://example.com/image1.jpg');
      expect(media.mediaUrls[1], 'https://example.com/audio1.mp3');
    });

    test('should handle empty mediaUrls list', () {
      // Arrange & Act
      const media = Media(
        mediaId: 'media_002',
        meaningId: 'meaning_002',
        mediaUrls: [],
      );

      // Assert
      expect(media.mediaUrls.isEmpty, true);
    });
  });
}