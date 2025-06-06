import 'package:flutter_test/flutter_test.dart';

import '../../../lib/domain/models/comparison/comparison.dart';

void main() {
  group('Comparison', () {
    test('should create Comparison instance with all required fields', () {
      // Arrange & Act
      const comparison = Comparison(
        comparisonId: 'comparison_001',
        oldMediaId: 'media_001',
        newMediaId: 'media_002',
        selected: 'new',
      );

      // Assert
      expect(comparison.comparisonId, 'comparison_001');
      expect(comparison.oldMediaId, 'media_001');
      expect(comparison.newMediaId, 'media_002');
      expect(comparison.selected, 'new');
    });

    test('should handle different selection results', () {
      // Arrange & Act
      const comparison1 = Comparison(
        comparisonId: 'comparison_002',
        oldMediaId: 'media_003',
        newMediaId: 'media_004',
        selected: 'old',
      );

      const comparison2 = Comparison(
        comparisonId: 'comparison_003',
        oldMediaId: 'media_005',
        newMediaId: 'media_006',
        selected: 'both',
      );

      // Assert
      expect(comparison1.selected, 'old');
      expect(comparison2.selected, 'both');
    });
  });
}