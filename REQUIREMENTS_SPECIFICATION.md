# 英単語学習アプリ 要件定義書（Ultra Think Document）

## 1. プロジェクト概要

### 1.1 プロダクト概要
**タップル/Tinder風カードUIを採用した英単語学習モバイルアプリケーション**

### 1.2 主要機能
- スタックカードUIによる直感的な単語学習
- スワイプジェスチャーによる習得判定
- 間隔反復学習による効率的な復習システム
- 音声・画像・例文を含む多媒体学習体験
- 学習進捗の詳細な分析と統計表示

### 1.3 ターゲットユーザー
- 英語学習者（初級〜中級）
- 効率的な単語暗記を求めるユーザー
- ゲーミフィケーションされた学習体験を好むユーザー

---

## 2. 機能要件

### 2.1 カードUI学習機能（Core Feature）

#### 2.1.1 カード表示仕様
**表示内容**:
- **英単語**: メイン表示（大きなフォント）
- **発音記号**: 単語下部に小さく表示
- **画像**: カード上部に関連画像
- **日本語訳**: ホバー/長押し時のみ表示（半透明オーバーレイ）

**レイアウト**:
```
┌─────────────────────┐
│     [関連画像]        │
│                     │
│      English        │
│     /prənʌnsiˈeɪʃən/│
│                     │
│  [長押し時:日本語訳]   │
└─────────────────────┘
```

#### 2.1.2 操作仕様
**スワイプジェスチャー**:
- **右スワイプ**: 「知っている」判定 → 正解記録
- **左スワイプ**: 「覚えていない」判定 → 不正解記録
- **長押し/ホバー**: 日本語訳を一時表示

**スワイプ判定**:
- 水平移動距離: 画面幅の30%以上
- スワイプ速度: 最低閾値設定
- アニメーション: 滑らかなカード移動とフェード効果

#### 2.1.3 学習フロー
```
1. カードスタック表示（最大5枚重ね）
2. ユーザーがカード内容を確認
3. 必要に応じて長押しで日本語確認
4. スワイプで習得判定
5. 結果記録 & 次のカード表示
6. セッション完了時に統計表示
```

### 2.2 単語一覧機能

#### 2.2.1 表示仕様
**リスト形式レイアウト**:
```
┌─────────────────────────────────────┐
│ [フィルタ] [検索] [ソート]           │
├─────────────────────────────────────┤
│ Apple 🍎        [●学習中] 85%       │
│ noun | 最終: 2024/01/15            │
├─────────────────────────────────────┤
│ Beautiful ✨    [✓習得済] 100%      │  
│ adjective | 最終: 2024/01/14       │
└─────────────────────────────────────┘
```

**表示項目**:
- **主要情報**: 英単語、学習状況アイコン、正答率
- **副次情報**: 品詞、最終学習日、次回復習日
- **視覚的インジケーター**: 習得レベル別の色分け

#### 2.2.2 フィルタ・検索機能
**必須フィルタ**:
- 学習状況: `Learning` / `Reviewing` / `Mastered` / `All`

**オプション機能**:
- **単語検索**: 部分一致による絞り込み
- **品詞フィルタ**: 名詞、動詞、形容詞等による絞り込み
- **復習予定**: Today / This Week / Overdue

**ソート機能**:
- 追加日順（新しい→古い）
- 学習状況順
- 正答率順（低い→高い）
- 次回復習日順

### 2.3 音声・メディア機能

#### 2.3.1 音声再生機能
**発音音声**:
- カードタップで英単語の発音再生
- 一覧画面からも音声再生可能
- 音声ファイル形式: MP3/AAC

**例文音声**:
- 英語例文の音声再生
- ネイティブスピーカーによる自然な発音
- 再生速度調整（0.8x / 1.0x / 1.2x）

#### 2.3.2 画像表示機能
**関連画像**:
- 単語理解を助ける視覚的コンテンツ
- カードサイズに最適化された表示
- 画像形式: JPEG/PNG/WebP

### 2.4 例文機能

#### 2.4.1 例文表示
**表示内容**:
- **英語例文**: 単語の実用的な使用例
- **日本語訳**: 例文の意味理解支援
- **音声再生**: 例文の発音学習

**表示タイミング**:
- カード詳細ビュー（スワイプ上方向でアクセス）
- 単語一覧の詳細表示

### 2.5 学習統計・進捗機能

#### 2.5.1 統計表示
**ダッシュボード**:
- 総学習単語数
- 習得済み単語数・割合
- 今日の学習進捗
- 週間学習統計

**詳細統計**:
- 単語別学習履歴
- 正答率推移グラフ
- 学習時間統計
- 復習予定カレンダー

#### 2.5.2 進捗追跡
**習得レベル管理**:
- `Learning`: 初回学習段階
- `Reviewing`: 復習段階（間隔反復中）
- `Mastered`: 習得完了

**復習スケジューリング**:
- 間隔反復学習アルゴリズム実装
- 正解時: 復習間隔延長（1日→3日→7日→14日→30日）
- 不正解時: 復習間隔リセット

---

## 3. 技術要件

### 3.1 データモデル設計

#### 3.1.1 既存エンティティ（DATABASE_STRUCTURE.md準拠）
**Flashcard** - メインエンティティ
```dart
@freezed
class Flashcard with _$Flashcard {
  const factory Flashcard({
    required String flashcardId,
    required Word word,
    required List<Meaning> meanings,
    required Media media,
    required String memo,
    required bool checkFlag,
  }) = _Flashcard;
}
```

**Word** - 英単語基本情報
```dart
@freezed  
class Word with _$Word {
  const factory Word({
    required String wordId,
    required String word,
    required String coreMeaning,
    required String explanation,
  }) = _Word;
}
```

**Meaning** - 単語の意味・用法
```dart
@freezed
class Meaning with _$Meaning {
  const factory Meaning({
    required String meaningId,
    required PartOfSpeech pos,
    required String translation,
    required String pronunciation,
    required String exampleEng,
    required String exampleJpn,
  }) = _Meaning;
}

enum PartOfSpeech {
  noun, pronoun, intransitiveVerb, transitiveVerb,
  adjective, adverb, preposition, conjunction, interjection
}
```

**Media** - マルチメディアコンテンツ
```dart
@freezed
class Media with _$Media {
  const factory Media({
    required String mediaId,
    required String meaningId,
    required List<String> mediaUrls,
  }) = _Media;
}
```

#### 3.1.2 新規エンティティ（学習進捗管理）

**LearningRecord** - 個別学習記録
```dart
@freezed
class LearningRecord with _$LearningRecord {
  const factory LearningRecord({
    required String recordId,
    required String flashcardId,
    required DateTime studyDate,
    required LearningAction action,
    required int responseTimeMs,
    required String sessionId,
  }) = _LearningRecord;
}

enum LearningAction { correct, incorrect }
```

**StudyStatistics** - 単語別統計情報
```dart
@freezed
class StudyStatistics with _$StudyStatistics {
  const factory StudyStatistics({
    required String flashcardId,
    required int totalAttempts,
    required int correctAttempts,
    required DateTime lastStudyDate,
    required MasteryLevel masteryLevel,
    required DateTime nextReviewDate,
    required double difficultyScore, // 0.0-1.0
  }) = _StudyStatistics;
}

enum MasteryLevel { learning, reviewing, mastered }
```

**StudySession** - 学習セッション記録
```dart
@freezed
class StudySession with _$StudySession {
  const factory StudySession({
    required String sessionId,
    required DateTime startTime,
    DateTime? endTime,
    required int totalCards,
    required int correctCount,
    required int incorrectCount,
  }) = _StudySession;
}
```

### 3.2 UI/UX設計要件

#### 3.2.1 カードスタックUI実装
**技術スタック**:
- `flutter_card_swiper` or カスタム実装
- `AnimationController` for smooth transitions
- `GestureDetector` for swipe recognition

**アニメーション仕様**:
- スワイプ中のリアルタイム回転・移動
- 背景カードの3D depth effect
- スワイプ方向に応じたカラーフィードバック（緑/赤）

#### 3.2.2 音声再生システム
**技術スタック**:
- `audioplayers` package
- 音声ファイル管理: Assets + Remote URL対応
- バックグラウンド再生制御

#### 3.2.3 レスポンシブデザイン
**対応デバイス**:
- iPhone: SE (375px) ～ Pro Max (428px)
- Android: 360px ～ 420px width
- タブレット対応: 768px+ width

### 3.3 アーキテクチャ要件

#### 3.3.1 Clean Architecture準拠
```
lib/
├── domain/models/           # ビジネスエンティティ
│   ├── flashcard/
│   ├── learning_record/
│   └── study_statistics/
├── data/repositories/       # データアクセス層
│   ├── flashcard/
│   ├── learning/
│   └── statistics/
└── ui/                     # プレゼンテーション層
    ├── study/              # カード学習画面
    ├── word_list/          # 単語一覧画面
    └── statistics/         # 統計画面
```

#### 3.3.2 状態管理
**Riverpod + MVVM Pattern**:
- Providers for dependency injection and state management
- StateNotifier/AsyncNotifier for business logic
- FutureProvider/StreamProvider for async operations
- Result<T> pattern for error handling

---

## 4. 非機能要件

### 4.1 パフォーマンス要件
**応答性能**:
- カードスワイプ操作: 16ms以下のフレームレート維持
- 音声再生開始: 200ms以内
- 画面遷移: 300ms以内

**メモリ使用量**:
- アプリ起動時: 100MB以下
- 画像キャッシュ: 50MB以下
- 音声キャッシュ: 30MB以下

### 4.2 ユーザビリティ要件
**操作性**:
- 片手操作での快適な使用
- 直感的なジェスチャー操作
- アクセシビリティ準拠（VoiceOver/TalkBack対応）

**学習効率性**:
- 1セッション5-15分での区切り学習
- 間隔反復学習による記憶定着最適化
- 学習進捗の視覚的フィードバック

### 4.3 品質要件
**信頼性**:
- 学習記録の確実な保存
- アプリクラッシュ率: 0.1%以下
- データ整合性の保証

**保守性**:
- Clean Architectureによる疎結合設計
- テストカバレッジ: 80%以上
- コード規約準拠（CLAUDE.md）

---

## 5. 開発スコープ・制約

### 5.1 実装スコープ
**Phase 1実装対象**:
- ✅ カードUI基本機能
- ✅ スワイプ操作・学習記録
- ✅ 単語一覧・フィルタ機能
- ✅ 音声再生・画像表示
- ✅ 基本統計表示

**Phase 1除外項目**:
- ❌ ユーザー登録・認証機能
- ❌ 単語追加・編集機能  
- ❌ ソーシャル機能
- ❌ オンライン同期

### 5.2 技術制約
**開発環境**:
- Flutter 3.x
- Dart 3.x
- Clean Architecture準拠

**データ制約**:
- ローカルデータベース使用（sqlite）
- 単語データ: assets/json形式で事前定義
- メディアファイル: assets + URL参照

---

## 6. 実装フェーズ計画

### Phase 1: Core MVP（2-3週間）
1. **Week 1**: データモデル・Repository実装
   - Freezed models作成
   - Local repository実装
   - 基本テストデータ準備

2. **Week 2**: カードUI・学習機能実装
   - カードスタックUI構築
   - スワイプ操作実装
   - 学習記録システム

3. **Week 3**: 一覧・統計機能実装
   - 単語一覧画面
   - フィルタ・検索機能
   - 基本統計表示

### Phase 2: Enhancement（1-2週間）
4. **音声・メディア機能強化**
   - 音声再生システム
   - 画像表示最適化
   - 例文機能実装

5. **UX改善・テスト**
   - アニメーション改善
   - パフォーマンス最適化
   - 総合テスト

### Phase 3: Polish（1週間）
6. **最終調整**
   - バグ修正
   - UI/UX改善
   - リリース準備

---

## 7. 成功指標

### 7.1 技術指標
- ✅ 全機能要件の実装完了
- ✅ テストカバレッジ80%達成
- ✅ パフォーマンス要件クリア

### 7.2 ユーザー体験指標
- ✅ 直感的な操作性の実現
- ✅ 学習効率の向上実感
- ✅ 継続的な学習習慣の形成支援

---

## 8. 技術参考資料

### 8.1 関連ドキュメント
- `DATABASE_STRUCTURE.md`: データモデル詳細設計
- `CLAUDE.md`: 開発規約・アーキテクチャガイド
- フロントエンド参考: https://github.com/KyoyaIwatsuru/zenn-hack-frontend

### 8.2 主要パッケージ
```yaml
dependencies:
  flutter: sdk
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  riverpod_annotation: ^2.3.3
  go_router: ^13.0.0
  audioplayers: ^5.2.1
  sqlite3_flutter_libs: ^0.5.15
  flutter_card_swiper: ^6.2.0
  flutter_hooks: ^0.21.2
  hooks_riverpod: ^2.6.1

dev_dependencies:
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  riverpod_generator: ^2.3.9
  custom_lint: ^0.5.7
  riverpod_lint: ^2.3.7
  mocktail: ^1.0.1
  flutter_test: sdk
```

---

**Document Version**: 1.0  
**Last Updated**: 2024/01/15  
**Author**: Claude Code  
**Status**: Requirements Approved ✅