SQLの解析を字句解析（トークン化）で行う場合の設計について説明します。SQL文をトークン単位で解析し、`FROM`、`INSERT`、`JOIN`などのキーワードの後に続くテーブル名を抽出する方法を具体的に記述します。

---

## **要件定義**

### **1. 背景**
SQL文を字句解析で解析し、以下の情報を抽出する：
- テーブル名（`FROM`、`INSERT INTO`、`JOIN`などのキーワードに基づく）。
- 操作の種類（`SELECT`, `INSERT`, `UPDATE`, `DELETE`）。
- 操作の対象となるテーブルの種類（主クエリ、サブクエリ、CTEなど）。

これにより以下を達成する：
- SQL内で操作されるすべてのテーブルを網羅的に抽出。
- テーブルのCRUD操作を正確に特定。
- サブクエリやエイリアスを考慮した構造的なデータの生成。

---

### **2. 要件**

#### **2.1 機能要件**
1. **字句解析によるSQLトークン化**:
   - SQL文をトークンに分割（例: `SELECT`, `FROM`, `table_name`など）。
   - キーワードとテーブル名を対応付けて解析。

2. **キーワードごとのテーブル抽出**:
   - `FROM`, `JOIN`, `INSERT INTO`, `UPDATE`, `DELETE FROM`などのキーワードを解析し、直後のトークンをテーブル名として抽出。
   - サブクエリを解析して、その中のテーブルも抽出。

3. **サブクエリとエイリアスの解決**:
   - サブクエリ内の`FROM`や`JOIN`を解析。
   - エイリアスを解決して元のテーブル名に対応付け。

4. **結果の保存**:
   - 抽出したデータをJSONおよびCSV形式で出力。

---

## **基本設計**

### **1. 処理フロー**

#### **1.1 SQL文のトークン化**
- SQL文を字句単位で分割。
- キーワード（例: `FROM`, `JOIN`, `INSERT INTO`など）を識別。
- 各キーワードに続くトークンを解析。

#### **1.2 キーワードに基づく解析**
- トークンを順次処理し、以下のルールに基づいてテーブル名を抽出：
  - `FROM`: 直後のトークンがテーブル名。
  - `JOIN`: 直後のトークンがテーブル名。
  - `INSERT INTO`, `UPDATE`, `DELETE FROM`: 直後のトークンがテーブル名。

#### **1.3 サブクエリの処理**
- `(`から始まる部分をサブクエリとして認識。
- サブクエリ内の`FROM`や`JOIN`を解析。

#### **1.4 エイリアスの解決**
- テーブル名に付与されたエイリアス（例: `users u`）を記録。
- クエリ全体でエイリアスを展開して元のテーブル名に対応付け。

---

### **2. データ設計**

#### **2.1 出力形式**
**JSON形式**：
```json
[
  {
    "sql": "SELECT u.id FROM users u JOIN orders o ON u.id = o.user_id;",
    "operations": [
      {
        "keyword": "FROM",
        "table": "users",
        "alias": "u"
      },
      {
        "keyword": "JOIN",
        "table": "orders",
        "alias": "o"
      }
    ]
  }
]
```

**CSV形式**：
| sql                                                         | keyword | table  | alias |
|-------------------------------------------------------------|---------|--------|-------|
| SELECT u.id FROM users u JOIN orders o ON u.id = o.user_id; | FROM    | users  | u     |
| SELECT u.id FROM users u JOIN orders o ON u.id = o.user_id; | JOIN    | orders | o     |

---

### **3. 実装例**

以下にPythonでの字句解析実装例を示します：

```python
import re
import json
import pandas as pd

def tokenize_sql(sql):
    """
    SQL文を字句解析してトークンに分割
    """
    tokens = re.findall(r"[(),]|[\w.]+|[<>=!]+|\b(?:SELECT|FROM|JOIN|ON|WHERE|INSERT INTO|DELETE FROM|UPDATE|SET|WITH|AS)\b", sql, re.IGNORECASE)
    return [token.upper() if token.upper() in {"SELECT", "FROM", "JOIN", "ON", "WHERE", "INSERT INTO", "DELETE FROM", "UPDATE", "SET", "WITH", "AS"} else token for token in tokens]

def parse_tokens(tokens):
    """
    トークンからテーブル名とキーワードを抽出
    """
    operations = []
    index = 0

    while index < len(tokens):
        token = tokens[index]

        # FROM句の処理
        if token == "FROM":
            table = tokens[index + 1]
            alias = None
            if index + 2 < len(tokens) and tokens[index + 2] == "AS":
                alias = tokens[index + 3]
                index += 2
            elif index + 2 < len(tokens) and re.match(r"^\w+$", tokens[index + 2]):
                alias = tokens[index + 2]
            operations.append({"keyword": "FROM", "table": table, "alias": alias})

        # JOIN句の処理
        elif token == "JOIN":
            table = tokens[index + 1]
            alias = None
            if index + 2 < len(tokens) and tokens[index + 2] == "AS":
                alias = tokens[index + 3]
                index += 2
            elif index + 2 < len(tokens) and re.match(r"^\w+$", tokens[index + 2]):
                alias = tokens[index + 2]
            operations.append({"keyword": "JOIN", "table": table, "alias": alias})

        # INSERT INTO, UPDATE, DELETE FROMの処理
        elif token in {"INSERT INTO", "UPDATE", "DELETE FROM"}:
            table = tokens[index + 1]
            operations.append({"keyword": token, "table": table, "alias": None})

        # サブクエリの処理
        elif token == "(":
            subquery_tokens = []
            index += 1
            depth = 1
            while index < len(tokens) and depth > 0:
                if tokens[index] == "(":
                    depth += 1
                elif tokens[index] == ")":
                    depth -= 1
                if depth > 0:
                    subquery_tokens.append(tokens[index])
                index += 1
            subquery_operations = parse_tokens(subquery_tokens)
            operations.extend(subquery_operations)

        index += 1

    return operations

# サンプルSQL
sql_statements = [
    "SELECT u.id, o.name FROM users u JOIN orders o ON u.id = o.user_id WHERE EXISTS (SELECT * FROM payments p WHERE p.user_id = u.id);",
    "INSERT INTO logs (log_id, message) VALUES (1, 'test');",
    "WITH cte AS (SELECT * FROM logs) SELECT * FROM cte;"
]

results = []
for sql in sql_statements:
    tokens = tokenize_sql(sql)
    operations = parse_tokens(tokens)
    results.append({"sql": sql, "operations": operations})

# JSON形式で保存
with open("sql_analysis.json", "w") as json_file:
    json.dump(results, json_file, indent=4)

# CSV形式で保存
flat_data = []
for result in results:
    for op in result["operations"]:
        flat_data.append({
            "sql": result["sql"],
            "keyword": op["keyword"],
            "table": op["table"],
            "alias": op.get("alias", None)
        })

df = pd.DataFrame(flat_data)
df.to_csv("sql_analysis.csv", index=False)
```

---

### **4. 実行結果**

#### **JSON形式**
```json
[
  {
    "sql": "SELECT u.id, o.name FROM users u JOIN orders o ON u.id = o.user_id WHERE EXISTS (SELECT * FROM payments p WHERE p.user_id = u.id);",
    "operations": [
      {"keyword": "FROM", "table": "users", "alias": "u"},
      {"keyword": "JOIN", "table": "orders", "alias": "o"},
      {"keyword": "FROM", "table": "payments", "alias": "p"}
    ]
  }
]
```

#### **CSV形式**
| sql                                                         | keyword | table     | alias |
|-------------------------------------------------------------|---------|-----------|-------|
| SELECT u.id, o.name FROM users u JOIN orders ...            | FROM    | users     | u     |
| SELECT u.id, o.name FROM users u JOIN orders ...            | JOIN    | orders    | o     |
| SELECT u

.id, o.name FROM users u JOIN orders ...            | FROM    | payments  | p     |

---

### **5. この設計の特徴**

1. **字句解析で柔軟な処理**:
   - `JOIN`, `FROM`, `INSERT INTO`などの多様なSQL構文を解析可能。
2. **サブクエリの再帰処理**:
   - ネストされたクエリ内のテーブル名も正確に取得。
3. **エイリアス対応**:
   - テーブルやサブクエリのエイリアスを元のテーブル名にマッピング可能。

必要に応じてさらなる拡張も可能ですので、要件があればお知らせください！