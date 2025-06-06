import 'package:result_dart/result_dart.dart';

import '../../../domain/models/template/template.dart';

/// Abstract repository interface for Template entity
abstract class TemplateRepository {
  /// Gets all templates
  Future<Result<List<Template>>> getTemplates();

  /// Gets a single template by ID
  Future<Result<Template>> getTemplate(int id);

  /// Creates a new template
  Future<Result<Template>> createTemplate(Template template);

  /// Updates an existing template
  Future<Result<Template>> updateTemplate(Template template);

  /// Deletes a template by ID
  Future<Result<void>> deleteTemplate(int id);

  /// Gets templates by generation type
  Future<Result<List<Template>>> getTemplatesByType(String generationType);
}