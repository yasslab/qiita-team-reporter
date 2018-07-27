# Qiita:Team Reporter

This creates a report based on daily reports in your Qiita:Team.


## できること

本リポジトリにあるスクリプトを使うと、下記が実行できます。

- Qiita:Team内の特定のタグがついている投稿を取り出す
- 取り出した結果を投稿者のidで絞り込む
- 取り出した結果からタイトルだけを出力する

例えば特定のタグを取得して、最後に`| sort > report.csv` などと繋げることで、日報から様々なレポートを作ることも可能です。

## 例: 特定タグの投稿を取り出す方法

`qiita`コマンドで特定タグの記事を取得することができます。

```
% envchain qiita-team-reporter bundle exec qiita list_tag_items 日報/2017/09 -t yasslab
```

ページネーションのパラメータを指定すると、最大で100件ずつ取得することができます。

```
% envchain qiita-team-reporter bundle exec qiita list_tag_items 日報/2017/09 per_page=100 page=1 -t yasslab 
```

`jq`コマンドを使えば、特定の投稿者のidで絞り込むことができます。

```
% envchain qiita-team-reporter bundle exec qiita list_tag_items 日報/2017/09 per_page=100 page=1 -t yasslab | jq '.[] | .title'

% envchain qiita-team-reporter bundle exec qiita list_tag_items 日報/2017/09 per_page=100 page=1 -t yasslab | jq -r '.[] | select(.user.id == "yasulab") | .title'
```

- :memo: NOTE: 1ページにその人の投稿が1つもない状態はほぼ起きないはずなので、上記コマンドの`page=`の数字を増やしながら実行したり、結果が空になるまで取得するという処理にしても良さそうです。
- :memo: NOTE: 404が返るまで`page=n`のパラメータ渡すのを繰り返して`jq`で`cat`するシェルスクリプト書けばRuby必要ないかも? 🤔

### 別案: Rubyでタグが付いた記事を取得する

```rb
require 'qiita'
client = Qiita::Client.new(team: 'yasslab', access_token: ENV['QIITA_ACCESS_TOKEN'])
res = client.list_tag_items('日報/2017/09')
puts res.body.map {|i| i["title"] }

# 2017-09-08, YassLab, 1h, テンプレートに合わせてタグ修正
# ...
```

## 参考: Qiita gemの使い方

詳細は下記ドキュメントを参考に。
http://www.rubydoc.info/gems/qiita

### qiita gemを使う

次のような感じでenvchainで環境変数を設定してirbで試してみる

```
% envchain qiita-team-reporter irb
```

チームの記事を取る場合は`team`オプションを設定する

```rb
require 'qiita'
client = Qiita::Client.new(team: 'yasslab', access_token: ENV['QIITA_ACCESS_TOKEN'])
res = client.list_items
res.body.first.fetch('title')
# => "ライブラリを作るときpublicで書き始めた方がいい理由"
```

### アクセストークン管理

qiita gemは環境変数の`QIITA_ACCESS_TOKEN`にアクセストークンが設定されている場合CLIツールではそれを使う

> Accepts access token via -a, --access-token or QIITA_ACCESS_TOKEN environment variable.
https://github.com/increments/qiita-rb#access-token

発行したアクセストークンはenvchainで環境変数に入れておく

```
% envchain --set qiita-team-reporter QIITA_ACCESS_TOKEN
```

### アクセストークン発行

Qiitaのアカウント管理のアプリケーションの個人用アクセストークンを発行するから発行できます
https://qiita.com/settings/applications

とりあえずQiita:Teamにだけアクセス出来ればよいので以下にチェックを入れて発行。

:white_check_mark: read_qiita_team

### Qiita:Team API v2

リリースノート
http://blog.qiita.com/post/98796001374/qiita-api-v2

ドキュメント
http://qiita.com/api/v2/docs

ここから個人用アクセストークンを発行して使うのが一番手軽
https://qiita.com/settings/applications

## LICENSE

Copyright &copy; [YassLab](https://yasslab.jp/).

[![YassLab Logo](https://yasslab.jp/img/logo_rect_copy.png)](https://yasslab.jp/)

