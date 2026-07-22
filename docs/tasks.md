# manmoss_muscle 実装タスク

筋トレ管理アプリ(Rails Web アプリ)の実装タスク一覧。
最初のバージョンでは「トレーニング記録」と「記録の一覧/履歴」を対象とする。

- **アプリ形態**: Ruby on Rails(Web アプリ)
- **データベース**: MySQL
- **実行環境**: Docker / Docker Compose(アプリ・DB をコンテナで管理)
- **スコープ(v1)**: ユーザー登録・認証、トレーニング記録の登録、記録の一覧・履歴表示
- **認証**: Devise を利用(メールアドレス + パスワードでの登録・ログイン)

進め方:

- 上から順にタスクを実装していく。各タスクのチェックボックスは完了時に埋める。
- **各タスクを進めるたびに、内容をドキュメントへ逐一反映することを忘れない。**
  - `tasks.md`: 完了したタスクのチェックを埋め、必要ならタスクの追加・修正を行う。
  - `README.md`: セットアップ手順・使い方・環境情報など、変更が生じた箇所を都度更新する。
  - 実装とドキュメントを乖離させないため、コミット単位でドキュメントも合わせて更新する。

---

## 1. プロジェクト初期セットアップ

- [x] 1.1 Ruby / Rails のバージョンを決定し `.ruby-version` を用意する(Ruby 3.4.10 / Rails 8.1.3)
- [x] 1.2 `rails new` で MySQL 指定(`-d mysql`)のアプリを生成する(既存 `README.md` / `.gitignore` は維持)
- [ ] 1.3 `Gemfile` の整理(不要 gem の削除、必要 gem の追加)
- [x] 1.4 `bundle install` と初期動作確認(`rails server` で起動確認)
- [ ] 1.5 `config/database.yml` を MySQL 向けに設定し `rails db:create` を実行する

## 1'. Docker 環境の構築

- 開発用 Dockerfile は `Dockerfile.dev` という名前で管理する(`rails new` が生成する本番用 `Dockerfile` と共存させるため)。
  `docker-compose.yml` の `web.build.dockerfile` で `Dockerfile.dev` を明示的に指定している。

- [x] 1'.1 アプリ用の `Dockerfile.dev` を作成する(Ruby ベースイメージ、依存インストール)
- [x] 1'.2 `docker-compose.yml` を作成する(app / db(MySQL)サービスの定義)
- [x] 1'.3 DB データ永続化用の volume と環境変数(接続情報)を設定する
- [x] 1'.4 `config/database.yml` を Docker の DB サービスに合わせて設定する(`DATABASE_HOST` / `DATABASE_USER` / `DATABASE_PASSWORD` を参照するよう修正)
- [x] 1'.5 `docker compose build` で起動確認する(Ruby / Rails / MySQL クライアントのインストールを確認済み)
- [x] 1'.6 `docker compose run` 経由で `rails db:create` / `db:migrate` が実行できることを確認する
- [x] 1'.7 `.dockerignore` を用意する

## 2. データモデル設計

- 実際のテーブル構成は [data_model.md](data_model.md) の設計に合わせて `users` / `menus` / `workouts` / `workout_records` の4テーブルとした
  (当初案の Exercise / WorkoutLog という名称から変更。詳細は data_model.md 参照)。

- [x] 2.1 ユーザー(User)テーブルの設計(name・email・password_digest)
- [x] 2.2 種目(menus)テーブルの設計(name・body_part)
- [x] 2.3 トレーニング(workouts)・トレーニング記録(workout_records)テーブルの設計
      (workouts: user・date・memo / workout_records: workout・menu・weight・reps・sets)
- [x] 2.4 User / Menu / Workout / WorkoutRecord のマイグレーション作成と `rails db:migrate`
- [x] 2.5 モデル定義(アソシエーション定義済み。バリデーションは今後追記)
      - User: `has_many :workouts, dependent: :destroy`
      - Menu: `has_many :workout_records`
      - Workout: `belongs_to :user` / `has_many :workout_records, dependent: :destroy`
      - WorkoutRecord: `belongs_to :workout` / `belongs_to :menu`

## 2'. ユーザー登録・認証機能

- [ ] 2'.1 認証用 gem(Devise)の導入と初期設定(`rails generate devise:install`)
- [ ] 2'.2 User モデルの生成(`rails generate devise User`)とマイグレーション
- [ ] 2'.3 ユーザー登録(サインアップ)画面・フローの実装
- [ ] 2'.4 ログイン / ログアウト機能の実装
- [ ] 2'.5 未ログイン時のアクセス制御(`before_action :authenticate_user!`)
- [ ] 2'.6 ログインユーザーに紐づく記録のみを操作できるようにする(認可)
- [ ] 2'.7 サインアップ / ログイン画面の最低限のスタイリング

## 3. トレーニング記録機能(登録)

- [ ] 3.1 WorkoutLogs コントローラの `new` / `create` アクション
- [ ] 3.2 記録入力フォーム(種目・重量・回数・セット数・日付)の実装
- [ ] 3.3 バリデーションとエラーメッセージ表示
- [ ] 3.4 登録成功時のリダイレクトとフラッシュメッセージ

## 4. 記録の一覧/履歴機能

- [ ] 4.1 WorkoutLogs コントローラの `index` アクション
- [ ] 4.2 記録一覧の表示(新しい順、日付ごとの表示)
- [ ] 4.3 日付・種目による絞り込み/検索
- [ ] 4.4 記録の詳細表示(`show`)
- [ ] 4.5 記録の編集・削除(`edit` / `update` / `destroy`)

## 5. 画面・UI

- [ ] 5.1 共通レイアウト(ヘッダー、ナビゲーション)
- [ ] 5.2 トップページ(最近の記録などの導線)
- [ ] 5.3 最低限のスタイリング(見やすさ優先)

## 6. テスト

- [ ] 6.1 モデルのテスト(バリデーション、アソシエーション)
- [ ] 6.2 記録登録フローのテスト
- [ ] 6.3 一覧/履歴表示のテスト

## 7. 仕上げ

- [ ] 7.1 seed データの用意(動作確認用の種目・記録)
- [ ] 7.2 README にセットアップ手順・使い方を追記
- [ ] 7.3 全体の動作確認とリファクタリング

---

## 今後の拡張候補(v1 では対象外)

- 種目マスタの管理画面
- 進捗の可視化(重量・ボリュームの推移グラフ)
- プロフィール編集・パスワードリセット・SNS ログインなどの認証機能拡張
