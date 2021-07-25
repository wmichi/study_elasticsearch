## ドキュメントの登録

ドキュメントの登録は以下のいずれかでできる

- PUT /<target>/\_doc/<\_id>
- POST /<target>/\_doc/
- PUT /<target>/\_create/<\_id>
- POST /<target>/\_create/<\_id>

```bash
# マッピングの登録
PUT /new-index-401
{
    "settings": {
      "index.number_of_shards": 1,
      "index.number_of_replicas": 1,
      "index.write.wait_for_active_shards": 1
    },
    "mappings": {
        "properties": {
            "id": {
                "type": "keyword",
                "similarity": "boolean"
            },
            "name": {
                "type": "text"
            },
            "number": {
                "type": "integer"
            }
        }
    }
}

# ドキュメントの登録
PUT /new-index-401/_doc/document4001
{"id": "id-1", "name": "テスト", "number": 1}

POST /new-index-401/_doc/
{"id": "id-2", "name": "テスト", "number": 2}

PUT /new-index-401/_create/document4003
{"id": "id-3", "name": "サンプル", "number": 3}

PUT /new-index-401/_doc/document4004
{"id": "id-4", "name": "おためし", "number": 4}
```

登録されているか確認

```bash
GET /new-index-401/_search
{
  "size": 5,
  "query": {
    "match_all": {}
  }
}
```

## refresh_interval の確認

インデックス作成時、refresh_interval を-1 に設定することで定期的な Refresh 操作を無効にできる  
無効にしている間、インデックスに加えられた操作が検索に反映されない

```bash
# マッピングの登録
PUT /new-index-402
{
    "settings": {
      "index.number_of_shards": 1,
      "index.number_of_replicas": 1,
      "index.write.wait_for_active_shards": 1,
      "index.refresh_interval": -1
    },
    "mappings": {
        "properties": {
            "id": {
                "type": "keyword",
                "similarity": "boolean"
            },
            "name": {
                "type": "text"
            },
            "number": {
                "type": "integer"
            }
        }
    }
}

# ドキュメントの登録
POST /new-index-402/_doc/
{"id": "id-2", "name": "テスト", "number": 2}

# 検索　→　ヒットしない
GET /new-index-402/_search
{
  "size": 5,
  "query": {
    "match": {
      "id": "id-2"
    }
  }
}

# refresh_intervalを1秒に設定　→　設定変更した時点から定期的なRefreshが有効になる
PUT /new-index-402/_settings
{
  "index" : {
    "refresh_interval" : "1s"
  }
}

# 検索　→　ヒットする
GET /new-index-402/_search
{
  "size": 5,
  "query": {
    "match": {
      "id": "id-2"
    }
  }
}
```
