# Development Issues - 英単語学習アプリ

## Phase 1: Core MVP（Week 1-3）

### 📁 Week 1: Data Models & Repository Implementation

#### Issue #1: Setup Project Architecture & Dependencies
**Labels**: `setup`, `architecture`, `priority-high`
**Estimate**: 2 days

**Description:**
プロジェクトの基本構成とClean Architectureセットアップ

**Tasks:**
- [ ] `pubspec.yaml`の依存関係追加（Riverpod, Freezed, etc.）
- [ ] ディレクトリ構造作成（`lib/domain/`, `lib/data/`, `lib/ui/`）
- [ ] Riverpod Provider Scope設定
- [ ] `analysis_options.yaml`設定
- [ ] `build_runner`設定

**Acceptance Criteria:**
- Clean Architectureディレクトリ構造が完成
- 全依存関係がインストール済み
- `flutter analyze`がクリーン
- 基本的なProviderScopeが動作

**Reference:** `CLAUDE.md`, `REQUIREMENTS_SPECIFICATION.md`

---

#### Issue #2: Create Core Domain Models with Freezed
**Labels**: `domain`, `models`, `priority-high`
**Estimate**: 3 days

**Description:**
Freezed使用したコアドメインモデルの実装

**Tasks:**
- [ ] `Word`モデル実装 (word.dart)
- [ ] `Meaning`モデル + `PartOfSpeech` enum実装
- [ ] `Media`モデル実装
- [ ] `Flashcard`モデル実装（メインエンティティ）
- [ ] `LearningRecord`モデル + `LearningAction` enum実装
- [ ] `StudyStatistics`モデル + `MasteryLevel` enum実装
- [ ] `StudySession`モデル実装
- [ ] JSON serialization生成（build_runner実行）

**Acceptance Criteria:**
- 全Freezedモデルが生成エラーなく完成
- JSON serialization/deserializationが動作
- 各モデルの単体テスト作成
- DATABASE_STRUCTURE.mdとの整合性確認

**Reference:** `DATABASE_STRUCTURE.md` Section 3.1

---

#### Issue #3: Implement Repository Interfaces & Local Implementation
**Labels**: `data`, `repository`, `priority-high`
**Estimate**: 4 days

**Description:**
Repository Patternによるデータアクセス層実装

**Tasks:**
- [ ] `FlashcardRepository`抽象インターフェース
- [ ] `FlashcardRepositoryLocal`実装
- [ ] `LearningRepository`（学習記録用）
- [ ] `StatisticsRepository`（統計データ用）
- [ ] SQLite設定とテーブル作成
- [ ] 初期テストデータ作成（assets/data.json）
- [ ] Repository unit tests作成

**Acceptance Criteria:**
- 全Repositoryインターフェースが定義済み
- Local実装が基本CRUD操作完了
- SQLiteテーブル作成・初期データ投入
- Repository層のテストカバレッジ80%以上

**Files to create:**
- `lib/data/repositories/flashcard/flashcard_repository.dart`
- `lib/data/repositories/flashcard/flashcard_repository_local.dart`
- `lib/data/repositories/learning/learning_repository.dart`
- `lib/data/repositories/statistics/statistics_repository.dart`

---

#### Issue #4: Create Test Data & Assets Setup
**Labels**: `assets`, `test-data`, `priority-medium`
**Estimate**: 1 day

**Description:**
開発・テスト用の単語データとメディアアセット準備

**Tasks:**
- [ ] `assets/data/flashcards.json`作成（50-100単語）
- [ ] 基本画像アセット準備
- [ ] 音声ファイル準備（MP3形式）
- [ ] `pubspec.yaml`のアセット登録
- [ ] データローダー実装

**Acceptance Criteria:**
- 十分な量のテストデータが用意
- アセットが正常に読み込み可能
- 画像・音声ファイルが適切なサイズ

---

### 📱 Week 2: Card UI & Learning Features

#### Issue #5: Implement Card Stack UI Foundation
**Labels**: `ui`, `card-stack`, `priority-high`
**Estimate**: 3 days

**Description:**
カードスタックUIの基本実装

**Tasks:**
- [ ] `StudyScreen`基本レイアウト作成
- [ ] `FlashcardWidget`単体カード実装
- [ ] `CardStackWidget`複数カード表示
- [ ] カード表示内容（英単語、発音記号、画像）
- [ ] 長押し時の日本語訳オーバーレイ
- [ ] 基本アニメーション設定

**Acceptance Criteria:**
- カードが5枚重ねで表示される
- カード内容が要件通り表示
- 長押しで日本語訳が表示
- レスポンシブデザイン対応

**Files to create:**
- `lib/ui/study/widgets/study_screen.dart`
- `lib/ui/study/widgets/flashcard_widget.dart`
- `lib/ui/study/widgets/card_stack_widget.dart`

---

#### Issue #6: Implement Swipe Gestures & Recognition
**Labels**: `ui`, `gestures`, `priority-high`
**Estimate**: 3 days

**Description:**
スワイプジェスチャー認識と判定ロジック

**Tasks:**
- [ ] `GestureDetector`による基本スワイプ検出
- [ ] 右スワイプ（正解）判定
- [ ] 左スワイプ（不正解）判定
- [ ] スワイプ閾値設定（画面幅30%）
- [ ] スワイプ速度閾値設定
- [ ] スワイプ中のリアルタイムアニメーション
- [ ] カラーフィードバック（緑/赤）

**Acceptance Criteria:**
- 右/左スワイプが正確に判定される
- スワイプ中のビジュアルフィードバック
- 要件通りの閾値設定が機能
- スムーズなアニメーション

---

#### Issue #7: Implement Learning Record System
**Labels**: `business-logic`, `learning`, `priority-high`
**Estimate**: 2 days

**Description:**
学習記録とセッション管理システム

**Tasks:**
- [ ] `StudyNotifier`実装（Riverpod StateNotifier）
- [ ] スワイプ結果の記録ロジック
- [ ] `LearningRecord`作成・保存
- [ ] `StudySession`管理
- [ ] 学習統計の更新
- [ ] 次回復習日の計算

**Acceptance Criteria:**
- スワイプ操作が正確に記録される
- セッション管理が機能
- 間隔反復学習ロジック実装
- 統計データが正しく更新

**Files to create:**
- `lib/ui/study/notifiers/study_notifier.dart`

---

#### Issue #8: Implement Spaced Repetition Algorithm
**Labels**: `algorithm`, `learning`, `priority-high`
**Estimate**: 2 days

**Description:**
間隔反復学習アルゴリズムの実装

**Tasks:**
- [ ] 基本間隔反復ロジック（1→3→7→14→30日）
- [ ] 正解時の間隔延長
- [ ] 不正解時の間隔リセット
- [ ] 難易度スコア計算
- [ ] 復習予定日計算
- [ ] アルゴリズムのユニットテスト

**Acceptance Criteria:**
- 要件通りの間隔反復が機能
- 難易度に応じた適応的学習
- テストカバレッジ90%以上

---

### 📋 Week 3: Word List & Statistics Features

#### Issue #9: Implement Word List Screen
**Labels**: `ui`, `word-list`, `priority-high`
**Estimate**: 3 days

**Description:**
単語一覧画面の実装

**Tasks:**
- [ ] `WordListScreen`基本レイアウト
- [ ] `WordListItem`ウィジェット
- [ ] 一覧表示項目（単語、学習状況、正答率等）
- [ ] 学習状況アイコン表示
- [ ] 色分け表示（習得レベル別）
- [ ] リスト形式のレスポンシブ対応

**Acceptance Criteria:**
- 要件通りの表示項目が実装済み
- 視覚的に分かりやすいUI
- パフォーマンスが良好

**Files to create:**
- `lib/ui/word_list/widgets/word_list_screen.dart`
- `lib/ui/word_list/widgets/word_list_item.dart`

---

#### Issue #10: Implement Search & Filter Functionality
**Labels**: `feature`, `search-filter`, `priority-medium`
**Estimate**: 3 days

**Description:**
検索・フィルタ機能の実装

**Tasks:**
- [ ] 学習状況フィルタ（Learning/Reviewing/Mastered/All）
- [ ] 単語検索（部分一致）
- [ ] 品詞フィルタ（オプション）
- [ ] 復習予定フィルタ（Today/This Week/Overdue）
- [ ] ソート機能（日付順、学習状況順、正答率順等）
- [ ] `WordListNotifier`状態管理

**Acceptance Criteria:**
- 全フィルタ・検索機能が動作
- リアルタイム検索対応
- ソート機能が正確

**Files to create:**
- `lib/ui/word_list/notifiers/word_list_notifier.dart`

---

#### Issue #11: Implement Statistics Dashboard
**Labels**: `ui`, `statistics`, `priority-medium`
**Estimate**: 2 days

**Description:**
学習統計ダッシュボードの実装

**Tasks:**
- [ ] `StatisticsScreen`基本レイアウト
- [ ] 総学習単語数表示
- [ ] 習得済み単語数・割合
- [ ] 今日の学習進捗
- [ ] 週間学習統計
- [ ] プログレスバー・グラフ表示

**Acceptance Criteria:**
- 統計データが正確に表示
- 視覚的に分かりやすいUI
- リアルタイム更新

**Files to create:**
- `lib/ui/statistics/widgets/statistics_screen.dart`

---

## Phase 2: Enhancement（Week 4-5）

### 🔊 Audio & Media Features

#### Issue #12: Implement Audio Player System
**Labels**: `media`, `audio`, `priority-high`
**Estimate**: 3 days

**Description:**
音声再生システムの実装

**Tasks:**
- [ ] `AudioPlayerService`実装
- [ ] カードタップでの発音再生
- [ ] 例文音声再生
- [ ] 再生速度調整（0.8x/1.0x/1.2x）
- [ ] 音声ファイル管理（Assets + Remote URL）
- [ ] エラーハンドリング

**Acceptance Criteria:**
- 音声が200ms以内に再生開始
- 速度調整が機能
- メモリ効率的な実装

---

#### Issue #13: Implement Image Display & Optimization
**Labels**: `media`, `images`, `priority-medium`
**Estimate**: 2 days

**Description:**
画像表示機能と最適化

**Tasks:**
- [ ] 画像の適切なサイズ調整
- [ ] キャッシュ機能実装
- [ ] 画像ローディング状態表示
- [ ] エラー時のフォールバック
- [ ] メモリ使用量最適化

**Acceptance Criteria:**
- 画像が適切なサイズで表示
- キャッシュが50MB以下
- 滑らかな画像ローディング

---

#### Issue #14: Implement Example Sentences Feature
**Labels**: `feature`, `examples`, `priority-medium`
**Estimate**: 2 days

**Description:**
例文表示機能の実装

**Tasks:**
- [ ] カード詳細ビュー実装
- [ ] 例文表示（英語・日本語）
- [ ] 例文音声再生
- [ ] スワイプ上方向でのアクセス
- [ ] 一覧画面での詳細表示

**Acceptance Criteria:**
- 例文が適切に表示
- 音声再生が機能
- ユーザビリティが良好

---

### 🎨 UX Enhancement & Testing

#### Issue #15: Enhance Animations & Transitions
**Labels**: `ui`, `animations`, `priority-medium`
**Estimate**: 2 days

**Description:**
アニメーション・トランジションの改善

**Tasks:**
- [ ] カードスワイプアニメーション改善
- [ ] 3D depth effectの実装
- [ ] 画面遷移アニメーション
- [ ] マイクロインタラクション追加
- [ ] パフォーマンス最適化

**Acceptance Criteria:**
- 16ms以下のフレームレート維持
- 滑らかなアニメーション
- 直感的なフィードバック

---

#### Issue #16: Performance Optimization
**Labels**: `performance`, `optimization`, `priority-high`
**Estimate**: 2 days

**Description:**
パフォーマンス最適化とメモリ管理

**Tasks:**
- [ ] メモリ使用量監視・最適化
- [ ] 画像・音声キャッシュ最適化
- [ ] リスト表示の仮想化
- [ ] 不要なリビルド削減
- [ ] プロファイリング実施

**Acceptance Criteria:**
- 要件通りのメモリ使用量
- 滑らかなスクロール
- 応答時間の改善

---

#### Issue #17: Comprehensive Testing Implementation
**Labels**: `testing`, `quality`, `priority-high`
**Estimate**: 3 days

**Description:**
包括的なテスト実装

**Tasks:**
- [ ] Unit tests for all business logic
- [ ] Widget tests for UI components
- [ ] Integration tests for user flows
- [ ] Repository layer tests
- [ ] StateNotifier tests
- [ ] テストカバレッジ80%達成

**Acceptance Criteria:**
- テストカバレッジ80%以上
- 全主要機能のテスト完了
- CI/CDパイプライン設定

---

## Phase 3: Polish（Week 6）

### 🚀 Final Polish & Release Preparation

#### Issue #18: UI/UX Polish & Accessibility
**Labels**: `ui`, `accessibility`, `priority-medium`
**Estimate**: 2 days

**Description:**
UI/UXの最終調整とアクセシビリティ対応

**Tasks:**
- [ ] デザインの最終調整
- [ ] カラースキーム統一
- [ ] VoiceOver/TalkBack対応
- [ ] 片手操作最適化
- [ ] ダークモード対応検討

**Acceptance Criteria:**
- アクセシビリティガイドライン準拠
- 一貫したデザインシステム
- 優れたユーザビリティ

---

#### Issue #19: Error Handling & Edge Cases
**Labels**: `error-handling`, `stability`, `priority-high`
**Estimate**: 2 days

**Description:**
エラーハンドリングとエッジケース対応

**Tasks:**
- [ ] ネットワークエラー対応
- [ ] データ読み込みエラー処理
- [ ] 音声再生エラー対応
- [ ] 空状態の適切な表示
- [ ] エラーメッセージの改善

**Acceptance Criteria:**
- 全エラーケースが適切に処理
- ユーザーフレンドリーなエラーメッセージ
- アプリクラッシュ率0.1%以下

---

#### Issue #20: Release Preparation & Documentation
**Labels**: `release`, `documentation`, `priority-medium`
**Estimate**: 1 day

**Description:**
リリース準備とドキュメント整備

**Tasks:**
- [ ] README.md更新
- [ ] CHANGELOG.md作成
- [ ] API documentation生成
- [ ] Build configuration確認
- [ ] リリースノート作成

**Acceptance Criteria:**
- 完全なドキュメント
- リリース可能な状態
- 品質基準クリア

---

## 🏷️ Issue Labels

### Priority
- `priority-high`: 必須機能・ブロッカー
- `priority-medium`: 重要機能
- `priority-low`: 追加機能・改善

### Category
- `setup`: プロジェクト設定
- `domain`: ドメインモデル
- `data`: データアクセス層
- `ui`: ユーザーインターフェース
- `business-logic`: ビジネスロジック
- `feature`: 機能実装
- `testing`: テスト関連
- `performance`: パフォーマンス
- `documentation`: ドキュメント

### Component
- `architecture`: アーキテクチャ
- `models`: データモデル
- `repository`: リポジトリ
- `card-stack`: カードスタックUI
- `word-list`: 単語一覧
- `statistics`: 統計機能
- `audio`: 音声機能
- `animations`: アニメーション

---

## 📊 Development Metrics

### Definition of Done
- [ ] 機能要件完全実装
- [ ] Unit/Widget tests作成
- [ ] Code review完了
- [ ] Documentation更新
- [ ] Performance requirements満足
- [ ] Accessibility基準準拠

### Success Criteria
- テストカバレッジ: 80%以上
- パフォーマンス: 要件通りの応答時間
- 品質: クラッシュ率0.1%以下
- コード品質: flutter analyzeクリーン