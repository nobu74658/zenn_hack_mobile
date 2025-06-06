#!/bin/bash

# 英単語学習アプリ GitHub Issues作成スクリプト
# 実行前に: gh auth login を実行してGitHub認証を完了してください

echo "英単語学習アプリ GitHub Issues作成開始..."

# Phase 1 - Week 1: Data Models & Repository Implementation

echo "Creating Issue #1: Setup Project Architecture & Dependencies"
gh issue create \
  --title "Setup Project Architecture & Dependencies" \
  --label "setup,architecture,priority-high" \
  --body "## 概要
プロジェクトの基本構成とClean Architectureセットアップ

## 見積もり
2 days

## タスク
- [ ] pubspec.yamlの依存関係追加（Riverpod, Freezed, etc.）
- [ ] ディレクトリ構造作成（lib/domain/, lib/data/, lib/ui/）
- [ ] Riverpod Provider Scope設定
- [ ] analysis_options.yaml設定
- [ ] build_runner設定

## 受け入れ条件
- [ ] Clean Architectureディレクトリ構造が完成
- [ ] 全依存関係がインストール済み
- [ ] flutter analyzeがクリーン
- [ ] 基本的なProviderScopeが動作

## 参考資料
- CLAUDE.md
- REQUIREMENTS_SPECIFICATION.md

## Phase
Phase 1 - Week 1"

echo "Creating Issue #2: Create Core Domain Models with Freezed"
gh issue create \
  --title "Create Core Domain Models with Freezed" \
  --label "domain,models,priority-high" \
  --body "## 概要
Freezed使用したコアドメインモデルの実装

## 見積もり
3 days

## タスク
- [ ] Wordモデル実装 (word.dart)
- [ ] Meaningモデル + PartOfSpeech enum実装
- [ ] Mediaモデル実装
- [ ] Flashcardモデル実装（メインエンティティ）
- [ ] LearningRecordモデル + LearningAction enum実装
- [ ] StudyStatisticsモデル + MasteryLevel enum実装
- [ ] StudySessionモデル実装
- [ ] JSON serialization生成（build_runner実行）

## 受け入れ条件
- [ ] 全Freezedモデルが生成エラーなく完成
- [ ] JSON serialization/deserializationが動作
- [ ] 各モデルの単体テスト作成
- [ ] DATABASE_STRUCTURE.mdとの整合性確認

## 参考資料
- DATABASE_STRUCTURE.md Section 3.1

## Phase
Phase 1 - Week 1"

echo "Creating Issue #3: Implement Repository Interfaces & Local Implementation"
gh issue create \
  --title "Implement Repository Interfaces & Local Implementation" \
  --label "data,repository,priority-high" \
  --body "## 概要
Repository Patternによるデータアクセス層実装

## 見積もり
4 days

## タスク
- [ ] FlashcardRepository抽象インターフェース
- [ ] FlashcardRepositoryLocal実装
- [ ] LearningRepository（学習記録用）
- [ ] StatisticsRepository（統計データ用）
- [ ] SQLite設定とテーブル作成
- [ ] 初期テストデータ作成（assets/data.json）
- [ ] Repository unit tests作成

## 受け入れ条件
- [ ] 全Repositoryインターフェースが定義済み
- [ ] Local実装が基本CRUD操作完了
- [ ] SQLiteテーブル作成・初期データ投入
- [ ] Repository層のテストカバレッジ80%以上

## 作成ファイル
- lib/data/repositories/flashcard/flashcard_repository.dart
- lib/data/repositories/flashcard/flashcard_repository_local.dart
- lib/data/repositories/learning/learning_repository.dart
- lib/data/repositories/statistics/statistics_repository.dart

## Phase
Phase 1 - Week 1"

echo "Creating Issue #4: Create Test Data & Assets Setup"
gh issue create \
  --title "Create Test Data & Assets Setup" \
  --label "assets,test-data,priority-medium" \
  --body "## 概要
開発・テスト用の単語データとメディアアセット準備

## 見積もり
1 day

## タスク
- [ ] assets/data/flashcards.json作成（50-100単語）
- [ ] 基本画像アセット準備
- [ ] 音声ファイル準備（MP3形式）
- [ ] pubspec.yamlのアセット登録
- [ ] データローダー実装

## 受け入れ条件
- [ ] 十分な量のテストデータが用意
- [ ] アセットが正常に読み込み可能
- [ ] 画像・音声ファイルが適切なサイズ

## Phase
Phase 1 - Week 1"

# Phase 1 - Week 2: Card UI & Learning Features

echo "Creating Issue #5: Implement Card Stack UI Foundation"
gh issue create \
  --title "Implement Card Stack UI Foundation" \
  --label "ui,card-stack,priority-high" \
  --body "## 概要
カードスタックUIの基本実装

## 見積もり
3 days

## タスク
- [ ] StudyScreen基本レイアウト作成
- [ ] FlashcardWidget単体カード実装
- [ ] CardStackWidget複数カード表示
- [ ] カード表示内容（英単語、発音記号、画像）
- [ ] 長押し時の日本語訳オーバーレイ
- [ ] 基本アニメーション設定

## 受け入れ条件
- [ ] カードが5枚重ねで表示される
- [ ] カード内容が要件通り表示
- [ ] 長押しで日本語訳が表示
- [ ] レスポンシブデザイン対応

## 作成ファイル
- lib/ui/study/widgets/study_screen.dart
- lib/ui/study/widgets/flashcard_widget.dart
- lib/ui/study/widgets/card_stack_widget.dart

## Phase
Phase 1 - Week 2"

echo "Creating Issue #6: Implement Swipe Gestures & Recognition"
gh issue create \
  --title "Implement Swipe Gestures & Recognition" \
  --label "ui,gestures,priority-high" \
  --body "## 概要
スワイプジェスチャー認識と判定ロジック

## 見積もり
3 days

## タスク
- [ ] GestureDetectorによる基本スワイプ検出
- [ ] 右スワイプ（正解）判定
- [ ] 左スワイプ（不正解）判定
- [ ] スワイプ閾値設定（画面幅30%）
- [ ] スワイプ速度閾値設定
- [ ] スワイプ中のリアルタイムアニメーション
- [ ] カラーフィードバック（緑/赤）

## 受け入れ条件
- [ ] 右/左スワイプが正確に判定される
- [ ] スワイプ中のビジュアルフィードバック
- [ ] 要件通りの閾値設定が機能
- [ ] スムーズなアニメーション

## Phase
Phase 1 - Week 2"

echo "Creating Issue #7: Implement Learning Record System"
gh issue create \
  --title "Implement Learning Record System" \
  --label "business-logic,learning,priority-high" \
  --body "## 概要
学習記録とセッション管理システム

## 見積もり
2 days

## タスク
- [ ] StudyNotifier実装（Riverpod StateNotifier）
- [ ] スワイプ結果の記録ロジック
- [ ] LearningRecord作成・保存
- [ ] StudySession管理
- [ ] 学習統計の更新
- [ ] 次回復習日の計算

## 受け入れ条件
- [ ] スワイプ操作が正確に記録される
- [ ] セッション管理が機能
- [ ] 間隔反復学習ロジック実装
- [ ] 統計データが正しく更新

## 作成ファイル
- lib/ui/study/notifiers/study_notifier.dart

## Phase
Phase 1 - Week 2"

echo "Creating Issue #8: Implement Spaced Repetition Algorithm"
gh issue create \
  --title "Implement Spaced Repetition Algorithm" \
  --label "algorithm,learning,priority-high" \
  --body "## 概要
間隔反復学習アルゴリズムの実装

## 見積もり
2 days

## タスク
- [ ] 基本間隔反復ロジック（1→3→7→14→30日）
- [ ] 正解時の間隔延長
- [ ] 不正解時の間隔リセット
- [ ] 難易度スコア計算
- [ ] 復習予定日計算
- [ ] アルゴリズムのユニットテスト

## 受け入れ条件
- [ ] 要件通りの間隔反復が機能
- [ ] 難易度に応じた適応的学習
- [ ] テストカバレッジ90%以上

## Phase
Phase 1 - Week 2"

# Phase 1 - Week 3: Word List & Statistics Features

echo "Creating Issue #9: Implement Word List Screen"
gh issue create \
  --title "Implement Word List Screen" \
  --label "ui,word-list,priority-high" \
  --body "## 概要
単語一覧画面の実装

## 見積もり
3 days

## タスク
- [ ] WordListScreen基本レイアウト
- [ ] WordListItemウィジェット
- [ ] 一覧表示項目（単語、学習状況、正答率等）
- [ ] 学習状況アイコン表示
- [ ] 色分け表示（習得レベル別）
- [ ] リスト形式のレスポンシブ対応

## 受け入れ条件
- [ ] 要件通りの表示項目が実装済み
- [ ] 視覚的に分かりやすいUI
- [ ] パフォーマンスが良好

## 作成ファイル
- lib/ui/word_list/widgets/word_list_screen.dart
- lib/ui/word_list/widgets/word_list_item.dart

## Phase
Phase 1 - Week 3"

echo "Creating Issue #10: Implement Search & Filter Functionality"
gh issue create \
  --title "Implement Search & Filter Functionality" \
  --label "feature,search-filter,priority-medium" \
  --body "## 概要
検索・フィルタ機能の実装

## 見積もり
3 days

## タスク
- [ ] 学習状況フィルタ（Learning/Reviewing/Mastered/All）
- [ ] 単語検索（部分一致）
- [ ] 品詞フィルタ（オプション）
- [ ] 復習予定フィルタ（Today/This Week/Overdue）
- [ ] ソート機能（日付順、学習状況順、正答率順等）
- [ ] WordListNotifier状態管理

## 受け入れ条件
- [ ] 全フィルタ・検索機能が動作
- [ ] リアルタイム検索対応
- [ ] ソート機能が正確

## 作成ファイル
- lib/ui/word_list/notifiers/word_list_notifier.dart

## Phase
Phase 1 - Week 3"

echo "Creating Issue #11: Implement Statistics Dashboard"
gh issue create \
  --title "Implement Statistics Dashboard" \
  --label "ui,statistics,priority-medium" \
  --body "## 概要
学習統計ダッシュボードの実装

## 見積もり
2 days

## タスク
- [ ] StatisticsScreen基本レイアウト
- [ ] 総学習単語数表示
- [ ] 習得済み単語数・割合
- [ ] 今日の学習進捗
- [ ] 週間学習統計
- [ ] プログレスバー・グラフ表示

## 受け入れ条件
- [ ] 統計データが正確に表示
- [ ] 視覚的に分かりやすいUI
- [ ] リアルタイム更新

## 作成ファイル
- lib/ui/statistics/widgets/statistics_screen.dart

## Phase
Phase 1 - Week 3"

# Phase 2 - Enhancement: Audio & Media Features

echo "Creating Issue #12: Implement Audio Player System"
gh issue create \
  --title "Implement Audio Player System" \
  --label "media,audio,priority-high" \
  --body "## 概要
音声再生システムの実装

## 見積もり
3 days

## タスク
- [ ] AudioPlayerService実装
- [ ] カードタップでの発音再生
- [ ] 例文音声再生
- [ ] 再生速度調整（0.8x/1.0x/1.2x）
- [ ] 音声ファイル管理（Assets + Remote URL）
- [ ] エラーハンドリング

## 受け入れ条件
- [ ] 音声が200ms以内に再生開始
- [ ] 速度調整が機能
- [ ] メモリ効率的な実装

## Phase
Phase 2 - Enhancement"

echo "Creating Issue #13: Implement Image Display & Optimization"
gh issue create \
  --title "Implement Image Display & Optimization" \
  --label "media,images,priority-medium" \
  --body "## 概要
画像表示機能と最適化

## 見積もり
2 days

## タスク
- [ ] 画像の適切なサイズ調整
- [ ] キャッシュ機能実装
- [ ] 画像ローディング状態表示
- [ ] エラー時のフォールバック
- [ ] メモリ使用量最適化

## 受け入れ条件
- [ ] 画像が適切なサイズで表示
- [ ] キャッシュが50MB以下
- [ ] 滑らかな画像ローディング

## Phase
Phase 2 - Enhancement"

echo "Creating Issue #14: Implement Example Sentences Feature"
gh issue create \
  --title "Implement Example Sentences Feature" \
  --label "feature,examples,priority-medium" \
  --body "## 概要
例文表示機能の実装

## 見積もり
2 days

## タスク
- [ ] カード詳細ビュー実装
- [ ] 例文表示（英語・日本語）
- [ ] 例文音声再生
- [ ] スワイプ上方向でのアクセス
- [ ] 一覧画面での詳細表示

## 受け入れ条件
- [ ] 例文が適切に表示
- [ ] 音声再生が機能
- [ ] ユーザビリティが良好

## Phase
Phase 2 - Enhancement"

echo "Creating Issue #15: Enhance Animations & Transitions"
gh issue create \
  --title "Enhance Animations & Transitions" \
  --label "ui,animations,priority-medium" \
  --body "## 概要
アニメーション・トランジションの改善

## 見積もり
2 days

## タスク
- [ ] カードスワイプアニメーション改善
- [ ] 3D depth effectの実装
- [ ] 画面遷移アニメーション
- [ ] マイクロインタラクション追加
- [ ] パフォーマンス最適化

## 受け入れ条件
- [ ] 16ms以下のフレームレート維持
- [ ] 滑らかなアニメーション
- [ ] 直感的なフィードバック

## Phase
Phase 2 - Enhancement"

echo "Creating Issue #16: Performance Optimization"
gh issue create \
  --title "Performance Optimization" \
  --label "performance,optimization,priority-high" \
  --body "## 概要
パフォーマンス最適化とメモリ管理

## 見積もり
2 days

## タスク
- [ ] メモリ使用量監視・最適化
- [ ] 画像・音声キャッシュ最適化
- [ ] リスト表示の仮想化
- [ ] 不要なリビルド削減
- [ ] プロファイリング実施

## 受け入れ条件
- [ ] 要件通りのメモリ使用量
- [ ] 滑らかなスクロール
- [ ] 応答時間の改善

## Phase
Phase 2 - Enhancement"

echo "Creating Issue #17: Comprehensive Testing Implementation"
gh issue create \
  --title "Comprehensive Testing Implementation" \
  --label "testing,priority-high" \
  --body "## 概要
包括的なテスト実装

## 見積もり
3 days

## タスク
- [ ] Unit tests for all business logic
- [ ] Widget tests for UI components
- [ ] Integration tests for user flows
- [ ] Repository layer tests
- [ ] StateNotifier tests
- [ ] テストカバレッジ80%達成

## 受け入れ条件
- [ ] テストカバレッジ80%以上
- [ ] 全主要機能のテスト完了
- [ ] CI/CDパイプライン設定

## Phase
Phase 2 - Enhancement"

# Phase 3 - Polish: Final adjustments

echo "Creating Issue #18: UI/UX Polish & Accessibility"
gh issue create \
  --title "UI/UX Polish & Accessibility" \
  --label "ui,accessibility,priority-medium" \
  --body "## 概要
UI/UXの最終調整とアクセシビリティ対応

## 見積もり
2 days

## タスク
- [ ] デザインの最終調整
- [ ] カラースキーム統一
- [ ] VoiceOver/TalkBack対応
- [ ] 片手操作最適化
- [ ] ダークモード対応検討

## 受け入れ条件
- [ ] アクセシビリティガイドライン準拠
- [ ] 一貫したデザインシステム
- [ ] 優れたユーザビリティ

## Phase
Phase 3 - Polish"

echo "Creating Issue #19: Error Handling & Edge Cases"
gh issue create \
  --title "Error Handling & Edge Cases" \
  --label "error-handling,stability,priority-high" \
  --body "## 概要
エラーハンドリングとエッジケース対応

## 見積もり
2 days

## タスク
- [ ] ネットワークエラー対応
- [ ] データ読み込みエラー処理
- [ ] 音声再生エラー対応
- [ ] 空状態の適切な表示
- [ ] エラーメッセージの改善

## 受け入れ条件
- [ ] 全エラーケースが適切に処理
- [ ] ユーザーフレンドリーなエラーメッセージ
- [ ] アプリクラッシュ率0.1%以下

## Phase
Phase 3 - Polish"

echo "Creating Issue #20: Release Preparation & Documentation"
gh issue create \
  --title "Release Preparation & Documentation" \
  --label "release,documentation,priority-medium" \
  --body "## 概要
リリース準備とドキュメント整備

## 見積もり
1 day

## タスク
- [ ] README.md更新
- [ ] CHANGELOG.md作成
- [ ] API documentation生成
- [ ] Build configuration確認
- [ ] リリースノート作成

## 受け入れ条件
- [ ] 完全なドキュメント
- [ ] リリース可能な状態
- [ ] 品質基準クリア

## Phase
Phase 3 - Polish"

echo "GitHub Issues作成完了！"
echo "合計20個のissueが作成されました。"
echo ""
echo "Phase 1: Core MVP (Issue #1-11) - 2-3週間"
echo "Phase 2: Enhancement (Issue #12-17) - 1-2週間"
echo "Phase 3: Polish (Issue #18-20) - 1週間"
echo ""
echo "開発を開始する準備が整いました！"