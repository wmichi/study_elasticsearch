## とりあえずデータ登録と検索をする

### マッピングの登録

[Create index API](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html)を用いる  
以下を実行することで当該インデックスのマッピングと設定を登録できる（具体的な設定内容は後述）

```bash
PUT /new-index-001
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

以下のようなメッセージが出れば登録されている

```json
{
  "acknowledged": true,
  "shards_acknowledged": true,
  "index": "new-index-001"
}
```

以下でインデックスの一覧を確認できる

```bash
GET /_alias
```

### データの登録をする

[Index API](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-index_.html)を用いる  
登録の方法は複数あるが、ここでは POST を用いた以下の方法で実行する

```bash
POST /new-index-001/_doc
{
  "id": "id-1",
  "name": "テスト",
  "number": 1
}
```

`successful`が 1 になっていればドキュメント登録完了

### とりあえずの検索をする

[Search API](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-search.html)を用いて検索する  
以下を実行することで先ほど登録されたドキュメントを確認できる

```bash
GET /new-index-001/_search
{
  "size": 10,
  "query": {
    "match_all": {}
  }
}
```
