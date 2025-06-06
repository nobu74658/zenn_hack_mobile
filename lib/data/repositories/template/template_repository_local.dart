import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/template/template.dart';
import '../../services/local_data_service.dart';
import 'template_repository.dart';

/// Local implementation of TemplateRepository using JSON data
class TemplateRepositoryLocal implements TemplateRepository {
  TemplateRepositoryLocal({
    required LocalDataService localDataService,
  }) : _localDataService = localDataService;

  final LocalDataService _localDataService;
  final _log = Logger('TemplateRepositoryLocal');

  @override
  Future<Result<List<Template>>> getTemplates() async {
    try {
      final templates = await _localDataService.getTemplates();
      _log.fine('Loaded ${templates.length} templates');
      return Result.ok(templates);
    } on Exception catch (error) {
      _log.warning('Failed to get templates', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Template>> getTemplate(int id) async {
    try {
      final template = await _localDataService.getTemplateById(id);
      if (template == null) {
        return Result.error(Exception('Template not found with id: $id'));
      }
      _log.fine('Loaded template: ${template.name}');
      return Result.ok(template);
    } on Exception catch (error) {
      _log.warning('Failed to get template', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Template>> createTemplate(Template template) async {
    try {
      // In local implementation, we just return the template as created
      // In a real implementation, this would save to local storage
      _log.fine('Created template: ${template.name}');
      return Result.ok(template);
    } on Exception catch (error) {
      _log.warning('Failed to create template', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<Template>> updateTemplate(Template template) async {
    try {
      // In local implementation, we just return the updated template
      // In a real implementation, this would update local storage
      _log.fine('Updated template: ${template.name}');
      return Result.ok(template);
    } on Exception catch (error) {
      _log.warning('Failed to update template', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> deleteTemplate(int id) async {
    try {
      // In local implementation, we just return success
      // In a real implementation, this would delete from local storage
      _log.fine('Deleted template with id: $id');
      return Result.ok(null);
    } on Exception catch (error) {
      _log.warning('Failed to delete template', error);
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<Template>>> getTemplatesByType(String generationType) async {
    try {
      final templates = await _localDataService.getTemplates();
      final filtered = templates.where((t) => t.generationType == generationType).toList();
      _log.fine('Found ${filtered.length} templates of type: $generationType');
      return Result.ok(filtered);
    } on Exception catch (error) {
      _log.warning('Failed to get templates by type', error);
      return Result.error(error);
    }
  }
}