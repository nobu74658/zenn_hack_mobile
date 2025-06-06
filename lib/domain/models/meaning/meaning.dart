import 'package:freezed_annotation/freezed_annotation.dart';

import 'part_of_speech.dart';

part 'meaning.freezed.dart';
part 'meaning.g.dart';

/// Represents different meanings/uses of a word
@freezed
class Meaning with _$Meaning {
  const factory Meaning({
    /// Primary key identifier for the meaning
    required String meaningId,
    
    /// Part of speech for this meaning
    required PartOfSpeech pos,
    
    /// Translated meaning in the target language
    required String translation,
    
    /// Pronunciation guide for this meaning
    required String pronunciation,
    
    /// English example sentence demonstrating usage
    required String exampleEng,
    
    /// Japanese example sentence translation
    required String exampleJpn,
  }) = _Meaning;

  factory Meaning.fromJson(Map<String, Object?> json) => _$MeaningFromJson(json);
}