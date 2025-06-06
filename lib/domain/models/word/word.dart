import 'package:freezed_annotation/freezed_annotation.dart';

part 'word.freezed.dart';
part 'word.g.dart';

/// Represents a single English word with its core information
@freezed
class Word with _$Word {
  const factory Word({
    /// Primary key identifier for the word
    required String wordId,
    
    /// The actual English word
    required String word,
    
    /// Primary definition of the word
    required String coreMeaning,
    
    /// Detailed explanation of the word
    required String explanation,
  }) = _Word;

  factory Word.fromJson(Map<String, Object?> json) => _$WordFromJson(json);
}