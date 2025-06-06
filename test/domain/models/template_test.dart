import 'package:flutter_test/flutter_test.dart';

import '../../../lib/domain/models/template/template.dart';

void main() {
  group('Template', () {
    test('should create Template instance with all required fields', () {
      // Arrange & Act
      const template = Template(
        templateId: 'template_001',
        name: 'Basic Vocabulary Template',
        description: 'Template for generating basic vocabulary flashcards',
        generationType: 'vocabulary',
        promptText: 'Generate a flashcard for the word: {word}',
      );

      // Assert
      expect(template.templateId, 'template_001');
      expect(template.name, 'Basic Vocabulary Template');
      expect(template.description, 'Template for generating basic vocabulary flashcards');
      expect(template.generationType, 'vocabulary');
      expect(template.promptText, 'Generate a flashcard for the word: {word}');
    });

    test('should support different generation types', () {
      // Arrange & Act
      const template1 = Template(
        templateId: 'template_002',
        name: 'Grammar Template',
        description: 'Template for grammar rules',
        generationType: 'grammar',
        promptText: 'Explain the grammar rule: {rule}',
      );

      const template2 = Template(
        templateId: 'template_003',
        name: 'Phrase Template',
        description: 'Template for common phrases',
        generationType: 'phrase',
        promptText: 'Create examples for the phrase: {phrase}',
      );

      // Assert
      expect(template1.generationType, 'grammar');
      expect(template2.generationType, 'phrase');
    });
  });
}