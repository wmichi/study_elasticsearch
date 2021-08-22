## snapshot の作成

### repository の作成

Kibana から以下のようなリクエストを行うことで Snapshot の作成が可能

```json
PUT /_snapshot/my_fs_backup
{
  "type": "fs",
  "settings": {
    "location": "/usr/share/elasticsearch/data/backup",
    "compress": true
  }
}

PUT /_snapshot/my_s3_backup
{
  "type": "s3",
  "settings": {
    "bucket": "my-s3-bucket",
    "region": "us-east-1"
  }
}
```

#### type に fs を指定する場合

elasticsearch.yml に以下のような設定を加える必要がある

```yml
path:
  repo: my/own/path
```

ここで指定するパスの所有者は`elasticsearch`ユーザでないといけないため、`chown elasticsearch my/own/path`で所有者を変更しておく

#### type に s3 を指定する場合

`repository-s3`のプラグインが必要  
ES のコンテナ内で以下を実行する（[参考リンク](https://www.elastic.co/guide/en/elasticsearch/plugins/7.14/repository-s3.html)）

```bash
bin/elasticsearch-plugin install repository-s3
```

インストール後コンテナを再起動し、プラグインのインストールが完了していることを以下のコマンドで確認

```bash
curl http://localhost:9200/_nodes?filter_path=nodes.*.plugins
```

### snapshot の作成

```json
PUT /_snapshot/my_fs_backup/snapshot_1?wait_for_completion=true
```

先ほど作成したディレクトリにスナップショットのデータが作成されていることを確認できる

### リストア

```json
// 作成済みのインデックスを削除
DELETE new-index-301

// リストア
POST /_snapshot/my_fs_backup/snapshot_1/_restore
{
  "indices": "new-index-301",
  "ignore_unavailable": true,
  "index_settings": {
    "index.number_of_replicas": 1
  },
  "ignore_index_settings": [
    "index.refresh_interval"
  ]
}

// 削除したインデックスが復元されていることを確認
GET new-index-301/_search
{
  "query": {
    "match_all": {}
  }
}
```

### 参考資料

https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html
https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html
https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-s3.html
