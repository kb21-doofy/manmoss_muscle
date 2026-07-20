# manmoss_muscle

筋トレを管理するためのアプリです。日々のトレーニング記録を残し、継続をサポートします。

## 開発の進め方

実装タスクは [tasks.md](tasks.md) にまとめています。上から順にタスクを進めてください。

## 主要コマンド

### イメージのビルド

```bash
docker compose build web
```

`Dockerfile.dev` を元に `web` サービスのイメージをビルドします。
`Gemfile` の `bundle install` までがイメージに含まれます。初回は数十秒〜数分かかりますが、
2回目以降は `Gemfile` に変更が無ければキャッシュが効いて数秒で終わります。

### コンテナ内シェルに入る

```bash
docker compose run --rm --no-deps web bash
```

`web` コンテナ内で対話的にシェルを操作したいとき(gem のバージョン確認、`rails` コマンドの試し実行など)に使います。
`exit` で抜けるとコンテナは自動削除されます。

> **現状の制約(2026-07-20 時点)**: `rails new` をまだ実行していないため、アプリ本体(`bin/rails` 等)が
> 存在しません。そのため `docker compose up`(`web` サービスのメインコマンド `bin/rails server` の起動)は
> まだ失敗します。`db` サービス単体の起動や `rails new` の実行手順は、実装が進み次第このセクションに追記します。
