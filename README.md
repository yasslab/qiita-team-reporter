# Qiita:Team Bot

Post work-in-progress report to Qiita:Team periodically.

# Setup
`QIITA_ACCESS_TOKEN`を設定する
アクセストークンの取得は[ドキュメント](http://qiita.com/api/v2/docs#認証認可)を参照

```
$ cp .envrc.sample .envrc
$ emacs .envrc
# QIITA_ACCESS_TOKEN=[取得したアクセストークン] を書く
$ direnv allow
```

[qiita-rb](https://github.com/increments/qiita-rb) のgemをインストールする

```sh
$ gem install qiita
```

Copyright &copy; 2017 [YassLab](https://yasslab.jp/)
