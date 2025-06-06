import 'package:freezed_annotation/freezed_annotation.dart';

import '../meaning/meaning.dart';
import '../media/media.dart';
import '../word/word.dart';

part 'flashcard.freezed.dart';
part 'flashcard.g.dart';

/// Central entity combining word, meanings, and user data
@freezed
class Flashcard with _$Flashcard {
  const factory Flashcard({
    /// Primary key identifier for the flashcard
    required String flashcardId,
    
    /// Embedded/Referenced Word object with core information
    required Word word,
    
    /// Array of related meanings for the word
    required List<Meaning> meanings,
    
    /// Associated media content for visual/audio learning
    required Media media,
    
    /// User's personal notes about this flashcard
    required String memo,
    
    /// Completion/mastery status flag
    required bool checkFlag,
  }) = _Flashcard;

  factory Flashcard.fromJson(Map<String, Object?> json) => _$FlashcardFromJson(json);
}