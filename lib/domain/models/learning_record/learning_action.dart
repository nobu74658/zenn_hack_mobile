/// Enum representing different learning actions performed by users
enum LearningAction {
  /// User viewed the flashcard
  viewed,
  
  /// User marked the card as known/mastered
  mastered,
  
  /// User marked the card as needs more practice
  needsPractice,
  
  /// User skipped the card
  skipped,
  
  /// User added or updated memo
  memoUpdated,
}