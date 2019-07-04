# README

##バージョン情報
*ruby 2.6.3p62
*Rails 5.2.3
*PostgreSQL 11.3

## テーブル
|User|Task|Label|TaskLabel|
|---|---|---|---|
|id|id|id|id|
|name|user_id|name|task_id|
|email|label_id||label_id|
|password_digest|deadline|||
||status|||
||priority|||

## Herokuへのデプロイ手順
アセットプリコンパイル実施
```
$ rails assets:precompile RAILS_ENV=production
```
add、コミット
```
$ git add 
```
```
$ git commit -m "(コミットメッセージ)"
```
Heroku上に新しいアプリケーションを作成
```
$ heroku create
```
Herokuにデプロイ
```
$ git push heroku master
```
データベースの移行
```
$ heroku run rails db:migrate
```
アプリ名を確認する方法
```
$ heroku config
```
ブラウザで以下のURLにアクセス
https://アプリ名.herokuapp.com/
