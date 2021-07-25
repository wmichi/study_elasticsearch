# study_elasticsearch

Elasticsearch の勉強用に作ったリポジトリ

## 環境構築

### Elasticsearch

ES のコンテナを立ち上げる  
今回はシングルノード

```bash
docker compose up -d
```

コンテナを立ち上げたら以下の curl コマンドでヘルスチェック  
立ち上げ完了まで少し時間がかかる

```bash
curl localhost:9200/_cat/health?v
```

また ES のコンテナ立ち上げ時、kibana も一緒に起動されている  
ブラウザにて[http://localhost:5601](http://localhost:5601)にアクセスすることで画面が表示される
