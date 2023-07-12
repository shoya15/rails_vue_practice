# Ruby on Rails x Vue.js practice
## 実際の動作

## References(memo.mdに補足あり)
1. Docker

https://qiita.com/tsuboyataiki/items/90dbe94553d3dea39b19

2. APIレンダリング(コントローラーにある`render_success`)って何だ？

https://techblog.kyamanak.com/entry/2017/12/03/185033

https://pikawaka.com/rails/json

3. execファイル

https://qiita.com/ko1nksm/items/98952723d7a71799673c

4. Usersコントローラー

https://qiita.com/typoerr/items/6d39617d969a1e8ca4e7

5. サインアップ/サインイン機能

https://qiita.com/RyotaIhara/items/4cd8c0f602426114e1b9

https://qiita.com/d0ne1s/items/7c4d2be3f53e34a9dec7

6. Vuex

https://youtu.be/tf6HWsyAVv4

7. なぜ、propsを使うときに`default: () => {}`のような書き方をするのか？

https://qiita.com/hogesuke_1/items/c74463de1a1eee802ca8

8. "インスタンス"(クラス(設計図)を具現化した実体のこと)の理解を深めたい

https://wa3.i-3-i.info/word1118.html

9. ログイン状況によりヘッダーの表示を変える

https://qiita.com/akki-memo/items/e20268b3690ef65728e1

10. リロードしてもログインを維持できるようにする

https://qiita.com/akki-memo/items/7bacb897e50025d23b76

11. `vuex-persistedstate`をインストールしたら出たエラーを解消する(エラーを解消する前も動作に支障はなかった)

https://techblog.lclco.com/entry/2021/12/17/100022

https://note.com/shisyamo_blog/n/n059d0c9b959a

12. ナビゲーションガード(アクセスを制限できる)

https://v3.router.vuejs.org/ja/guide/advanced/navigation-guards.html#%E3%82%AF%E3%82%99%E3%83%AD%E3%83%BC%E3%83%8F%E3%82%99%E3%83%AB%E3%83%92%E3%82%99%E3%83%95%E3%82%A9%E3%83%BC%E3%82%AB%E3%82%99%E3%83%BC%E3%83%88%E3%82%99

13. 外部キー( = データの整合性を保つ)について

https://www.sejuku.net/blog/54072

https://autovice.jp/articles/176

14. フォロー機能

https://qiita.com/nakachan1994/items/e6107fe3003f6515e385

15. Railsコントローラーデバック

https://style.potepan.com/articles/34859.html

16. ファイト（いいね）機能

https://qiita.com/RIN_HM/items/968abd9e31df6631a3ed

https://munerinlog.com/rails-like-function

17. JSDoc(可読性を上げる)

https://ics.media/entry/6789/

18. パスワードの表示切り替え

https://qiita.com/m_daichi/items/1a924b6a23ee704c349e

## Docker
下記のコマンド早見表のコマンドはコンテナに入ってからでないと実行できない
```bash
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
```bash
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
