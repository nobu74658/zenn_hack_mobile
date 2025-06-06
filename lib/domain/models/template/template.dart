import 'package:freezed_annotation/freezed_annotation.dart';

part 'template.freezed.dart';
part 'template.g.dart';

/// Predefined templates for content generation
@freezed
class Template with _$Template {
  const factory Template({
    /// Primary key identifier for the template
    required String templateId,
    
    /// Template name for display
    required String name,
    
    /// Detailed description of the template
    required String description,
    
    /// Type of content generation this template supports
    required String generationType,
    
    /// Generation prompt text used for content creation
    required String promptText,
  }) = _Template;

  factory Template.fromJson(Map<String, Object?> json) => _$TemplateFromJson(json);
}