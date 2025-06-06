import 'package:freezed_annotation/freezed_annotation.dart';

part 'comparison.freezed.dart';
part 'comparison.g.dart';

/// Tracks media comparison selections for A/B testing or user preference
@freezed
class Comparison with _$Comparison {
  const factory Comparison({
    /// Primary key identifier for the comparison
    required String comparisonId,
    
    /// Foreign key reference to the old/original Media.mediaId
    required String oldMediaId,
    
    /// Foreign key reference to the new/alternative Media.mediaId
    required String newMediaId,
    
    /// User's selection result (which media was preferred)
    required String selected,
  }) = _Comparison;

  factory Comparison.fromJson(Map<String, Object?> json) => _$ComparisonFromJson(json);
}