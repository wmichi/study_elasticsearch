## Bulk API を用いたドキュメントの登録

### 複数のドキュメントを一回で登録

複数のドキュメントを一回で登録するには Bulk API を使う必要がある

```bash
# 下準備
PUT /new-index-501
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

# Bulkでの投入
PUT /new-index-501/_bulk
{"create":{"_index": "new-index-501"}}
{"id": "id-1", "name": "テスト", "number": 1}
{"create":{"_index": "new-index-501"}}
{"id": "id-2", "name": "サンプル", "number": 2}
{"create":{"_index": "new-index-501"}}
{"id": "id-3", "name": "サンプル", "number": 3}
{"create":{"_index": "new-index-501"}}
{"id": "id-4", "name": "おためし", "number": 4}
{"create":{"_index": "new-index-501"}}
{"id": "id-5", "name": "サンプル", "number": 5}
{"create":{"_index": "new-index-501"}}
{"id": "id-6", "name": "おためし", "number": 6}
{"create":{"_index": "new-index-501"}}
{"id": "id-7", "name": "サンプル", "number": 7}
{"create":{"_index": "new-index-501"}}
{"id": "id-8", "name": "おためし", "number": 8}
{"create":{"_index": "new-index-501"}}
{"id": "id-9", "name": "テスト", "number": 9}
{"create":{"_index": "new-index-501"}}
{"id": "id-10", "name": "おためし", "number": 10}
```

### 速度の確認

```bash
# 下準備
PUT /new-index-502
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

# 1件ずつ登録する
time -p {
    curl -XPOST localhost:9200/new-index-502/_doc -H 'Content-Type: application/json' -d '{"id": "id-1", "name": "テスト", "number": 1}'
    curl -XPOST localhost:9200/new-index-502/_doc -H 'Content-Type: application/json' -d '{"id": "id-2", "name": "サンプル", "number": 2}'
    curl -XPOST localhost:9200/new-index-502/_doc -H 'Content-Type: application/json' -d '{"id": "id-3", "name": "サンプル", "number": 3}'
    curl -XPOST localhost:9200/new-index-502/_doc -H 'Content-Type: application/json' -d '{"id": "id-4", "name": "おためし", "number": 4}'
    curl -XPOST localhost:9200/new-index-502/_doc -H 'Content-Type: application/json' -d '{"id": "id-5", "name": "サンプル", "number": 5}'
    curl -XPOST localhost:9200/new-index-502/_doc -H 'Content-Type: application/json' -d '{"id": "id-6", "name": "おためし", "number": 6}'
    curl -XPOST localhost:9200/new-index-502/_doc -H 'Content-Type: application/json' -d '{"id": "id-7", "name": "サンプル", "number": 7}'
    curl -XPOST localhost:9200/new-index-502/_doc -H 'Content-Type: application/json' -d '{"id": "id-8", "name": "おためし", "number": 8}'
    curl -XPOST localhost:9200/new-index-502/_doc -H 'Content-Type: application/json' -d '{"id": "id-9", "name": "テスト", "number": 9}'
    curl -XPOST localhost:9200/new-index-502/_doc -H 'Content-Type: application/json' -d '{"id": "id-10", "name": "おためし", "number": 10}'
}

# Bulkでの投入
time curl -XPUT "localhost:9200/new-index-502/_bulk" -H 'Content-Type: application/json' -d '
{"create":{"_index": "new-index-502"}}
{"id": "id-1", "name": "テスト", "number": 1}
{"create":{"_index": "new-index-502"}}
{"id": "id-2", "name": "サンプル", "number": 2}
{"create":{"_index": "new-index-502"}}
{"id": "id-3", "name": "サンプル", "number": 3}
{"create":{"_index": "new-index-502"}}
{"id": "id-4", "name": "おためし", "number": 4}
{"create":{"_index": "new-index-502"}}
{"id": "id-5", "name": "サンプル", "number": 5}
{"create":{"_index": "new-index-502"}}
{"id": "id-6", "name": "おためし", "number": 6}
{"create":{"_index": "new-index-502"}}
{"id": "id-7", "name": "サンプル", "number": 7}
{"create":{"_index": "new-index-502"}}
{"id": "id-8", "name": "おためし", "number": 8}
{"create":{"_index": "new-index-502"}}
{"id": "id-9", "name": "テスト", "number": 9}
{"create":{"_index": "new-index-502"}}
{"id": "id-10", "name": "おためし", "number": 10}
'
```

当たり前だが一回一回 POST するより一回だけ POST する Bulk のほうが早い
