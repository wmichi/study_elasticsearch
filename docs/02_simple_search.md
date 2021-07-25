## 簡単な検索

### 下準備

本プロジェクト直下で以下を実行すると、インデックスの作成とドキュメントの登録を行う

```bash
bash bin/02.sh
```

### 簡単な検索

今回は`size`, `sort`, `query`, `_source`のみを用いた簡単な検索をする

```bash
GET /new-index-201/_search
{
  "size": 10,
  "sort": [
    {
      "number": {
        "order": "desc"
      }
    }
  ],
  "query": {
    "match_all": {}
  },
  "_source": [
    "name",
    "number"
  ]
}
```

クエリはもっと複雑にできるが、この資料を使って説明している会の本題と逸れるため割愛
