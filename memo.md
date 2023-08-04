  Future<dynamic> put(String endpoint, [params]) async {
    final uri = Uri.http(baseURL, endpoint, params);
    final headers = getHeaders();
    dynamic res = await http.put(uri, body: jsonEncode(params), headers: headers);
    return res;
  }

  Future<dynamic> delete(String endpoint, [params]) async {
    final uri = Uri.http(baseURL, endpoint, params);
    final headers = getHeaders();
    dynamic res = await http.delete(uri, headers: headers);
    return res;
  }


# メモ
## execファイルについて
1. "$*"よりも"$@"が良いみたい。予期せぬ変数展開やパス名展開が行われるのを防ぐために、$@をダブルクォーテーションで囲む
2. "$@": 引数すべてを意味する特殊なパラメーター(イメージは配列)
```
(例)
func() {
  echo "$@"
}
func a b c
#=> echo "a" "b" "c"
```
3. "$*": 文字列の結合(イメージはStr#join)
```
(例)
# 空白区切りの部分に`,`を挿入
IFS=","
func() {
  echo "$*"
}
func a b c 
#=> echo "a,b,c"
```

## Docker関連
1. Dockerアプリの再インストールは、アプリを消して、~/.dockerフォルダを`rm -rf ~/.docker`で削除してから行う

## Rails関連
1. Sessionsコントローラーでユーザーを判別する
2. コントローラーの`render_success`って何だ？
`app/controllers/concerns/api_rendering.rb`で設定してくれているみたい(リクエストが成功したら`render_json`を呼び出してjson形式でデータを飛ばす)
3. コントローラーのデバック
-> `pp`(`p`より見やすい)を使えばデータをターミナルから確認できる

## Vue関連
1. typeがtextの場合は省略できる
2. パス参照の`@`はsrcフォルダになっているっぽい
3. Vuex
state: 値を保持する

mutation: stateを更新する

payload: state.commitに追加で渡す引数のこと

action: mutationを指定する(commit)、methodで呼ばれる(dispatch)
4. 非同期処理(処理を同時に行うことで、処理時間を短縮する) <=> 同期処理(普通のプログラム = 前の処理が終わったら次の処理が実行される)
Promise or async/awaitを使う(async/awaitの方が直感的に分かりやすい)
5. タスクを完了させる機能を実装するときに、データを取得できずに詰まった...
`dispatch`とactionの引数は揃える必要がある！

-> dispatch("action_name", {引数}) <=> aciton_name({commit}, {引数})
または、dispatch("action_name", 引数(1つの場合のみ)) <=> action_name({commit}, 引数)

## Flutter関連
1. initState: Widgetの初期化時に一度だけ呼ばれる
2. 必ず存在するものは`required`する
3. `factory`でJSONデータをクラス(今回はArticleクラス)に変換することができる
4. `??`でnull判定

<!-- screensディレクトリ: ページを格納するディレクトリ -->
<!-- componentsディレクトリ: UIの設定 -->
##### トレンド記事一覧ページ
```dart
<!-- main.dart -->
上部のスタイルの設定 + homeプロパティはSearchScreenクラスを設定(トップページ)

<!-- screens/all_articles_screen.dart -->
getArticles関数で状態を更新(setState関数を使う)
→ このままだと反映されないので、initState関数で反映させる

getQiitaTrend関数でAPIリクエストを行い、データが取得できた場合は、JSONデータをArticleクラスに変換する

FutureBuilder: 非同期処理でWidgetを生成したい時に使う

<!-- components/article_container.dart -->
crossAxisAlignment: CrossAxisAlignment.start: 左寄せ
```

5. `prefs.getKeys()`とすることで、ローカルストレージに保存されているデータのキーをすべて取得できる

## GitHub関連
1. 作業ブランチにmaster(or main)ブランチを反映する
-> 作業ブランチにチェックアウトして、リモートリポジトリのmasterブランチ(origin master)をマージする
2. mastar -> development -> featureでブランチを切っていく

## データの流れ
### Rails x Vue
1. データは、json形式で飛ばす(コントローラー)
2. ルートを`scope :api`のところに書く
3. `route.rb`に書いたパスをstoreで使ってデータをAPI経由で取得する
例）api.get(/example);
4. storeにデータを保存する
5. 要件に応じてGETやPOSTを使い分けていく

