## インデックスの作成

### インデックスの作成

シャード数・レプリカ数 1 で、クイックスタートのときと同じインデックスを作成する  
またこの時点でエイリアスは設定していない

```bash
PUT /new-index-301
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
```

ドキュメントを登録する

```bash
POST /new-index-301/_doc
{
  "id": "id-1",
  "name": "テスト",
  "number": 1
}
```

### 動的なマッピング

明示的にインデックスにマッピングを登録しなくても、動的にマッピングを登録することが可能

```bash
POST /new-index-302/_doc
{
  "id": "id-1",
  "name": "テスト",
  "number": 1
}
```

ただし明示的にマッピングを登録したときとフィールド定義が異なる可能性があるので注意（以下 2 つは異なる結果を返す）

```bash
GET /new-index-301/_mapping
GET /new-index-302/_mapping
```

### エイリアスの登録

```bash
# 下準備
POST /new-index-303/_doc
{
  "id": "information-1022",
  "code": "info1022",
  "content": "This is a test"
}

# new-indexでnew-index-303が検索されるようにする
POST /_aliases
{
    "actions": [
        { "add": { "index" : "new-index-303", "alias" : "new-index" } }
    ]
}

# エイリアスを用いて検索
GET /new-index/_search
{
  "size": 5,
  "query": {
    "match_all": {}
  }
}

# エイリアスの切り替え
POST /_aliases
{
    "actions": [
        { "remove": { "index" : "new-index-303", "alias" : "new-index" } },
        { "add": { "index" : "new-index-301", "alias" : "new-index" } }
    ]
}

# もう一度エイリアスを用いて検索。検索結果が変わる
GET /new-index/_search
{
  "size": 5,
  "query": {
    "match_all": {}
  }
}
```
