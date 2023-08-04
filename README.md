# Ruby on Rails x Vue.js practice
## 実際の動作
https://github.com/shoya15/rails_vue_practice/assets/107241111/237b628b-1356-46fd-a627-f498e4d1d92d

上記動画にフォローを解除する操作を含めていませんでした。

↓ フォロー解除の様子

https://github.com/shoya15/rails_vue_practice/assets/107241111/7d0269a9-6536-4c9e-b542-8073ed33013e

## 使用したAPI
1. [Qiita Trend API](https://qiita-api.vercel.app)

2. Qiita API



## References
reference.mdに記載

## Docker
下記のコマンド早見表のコマンドはコンテナに入ってからでないと実行できない
```zsh
# Dockerアプリケーションを起動
# Dockerの起動
docker-compose up
# これ以降は、別タブでターミナルを開いてそこでコマンドを叩く
# 起動の確認(必要な場合)
docker-compose ps
#=> serviceのところにrailsとvueがあればO
# 初回なので、データベースを反映させておく
./rails_exec rails db:migrate
#=> 404エラーが消えて、Sample Pageが表示されるようになった！
```

### コンテナ内でのコマンド実行
*rails_exec* コマンドファイルと *vue_exec* コマンドファイルを利用して、コンテナ内部でコマンドを実行できます。

## コマンド早見表
※ 全てプロジェクトルートディレクトリで実行しています。
※ `chmod`で権利を付与している場合は`sudo`は不要
```zsh
# --- Rails ---

# bundle install
$ sudo ./rails_exec bundle install
# rails console
$ sudo ./rails_exec rails console
# migrate
$ sudo ./rails_exec rails db:migrate
# モデル作成
$ sudo ./rails_exec rails g model {モデル名}


# --- Vue ---

# npm install
$ sudo ./vue_exec npm install xxx
$ sudo ./vue_exec npm install
```
