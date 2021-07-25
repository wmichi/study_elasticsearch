ES_HOST=localhost
ES_PORT=9200
INDEX_NAME=new-index-201
SAMPLE_DIR=sample

# インデックスの作成
curl -XPUT "${ES_HOST}:${ES_PORT}/${INDEX_NAME}" -H 'Content-Type: application/json' -d '
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
'

# ドキュメントの登録
curl -XPOST "${ES_HOST}:${ES_PORT}/${INDEX_NAME}/_bulk?pretty" -H 'Content-Type: application/json' --data-binary @${SAMPLE_DIR}/02.json