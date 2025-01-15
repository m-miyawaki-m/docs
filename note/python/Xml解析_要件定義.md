以下に、**MyBatis XMLを解析し、SQLを分解して`namespace`と`tag id`、および関連するテーブルを出力するシステム**の要件定義と基本設計を記述します。

---

## **要件定義**

### **1. 背景**
MyBatisを使用したJavaプロジェクトにおいて、XMLファイル内の`namespace`、`tag id`、およびSQL構造を解析し、以下の情報を抽出する必要がある：
- `namespace`と`tag id`の一覧。
- SQLで操作されるテーブル名。
- SQLの種類（`SELECT`, `INSERT`, `UPDATE`, `DELETE`）。

この解析により、以下の目的を達成する：
- MyBatisの依存関係を特定。
- テーブルごとの操作一覧を可視化。
- メンテナンス性の向上と影響範囲の特定。

---

### **2. 要件**

#### **2.1 機能要件**
1. **MyBatis XMLの解析**:
   - MyBatis XMLファイルを読み込み、`namespace`とその内部の`<select>`、`<insert>`、`<update>`、`<delete>`タグを特定。
   - 各タグの`id`（`tag id`）を取得。

2. **SQLの分解**:
   - タグ内のSQL文を解析し、以下を抽出：
     - SQLの種類（`SELECT`, `INSERT`, `UPDATE`, `DELETE`）。
     - 操作対象のテーブル名。

3. **結果の保存**:
   - 抽出した情報をJSONおよびCSV形式で保存：
     - 各行に`namespace`、`tag id`、`SQL種類`、`操作テーブル`を含む。

4. **複数XMLファイルへの対応**:
   - プロジェクト全体のMyBatis XMLファイルを対象とする。

#### **2.2 非機能要件**
1. **解析の精度**:
   - SQL中のテーブル名を正確に抽出。
   - サブクエリや複数テーブル操作に対応。
2. **性能**:
   - XMLファイルが大量に存在する場合でも実行可能な速度を確保。
3. **汎用性**:
   - MyBatis以外のSQLフォーマットにも拡張可能な設計。

---

## **基本設計**

### **1. システム構成**

#### **1.1 主な構成要素**
- **入力**:
  - MyBatis XMLファイル（プロジェクト全体を対象とする）。
- **解析エンジン**:
  - XMLパーサで`namespace`とタグ情報を取得。
  - SQL解析エンジンでSQLを分解してテーブル名を抽出。
- **出力**:
  - JSONおよびCSV形式で解析結果を保存。

---

#### **1.2 フロー**
1. **XMLファイルの読み込み**:
   - 指定されたディレクトリからすべてのMyBatis XMLファイルを取得。

2. **`namespace`と`tag id`の解析**:
   - 各XMLファイルを解析し、`namespace`を取得。
   - 内部の`<select>`、`<insert>`、`<update>`、`<delete>`タグを特定し、`tag id`を抽出。

3. **SQLの解析**:
   - タグ内のSQL文を解析し、以下を特定：
     - SQLの種類（`SELECT`, `INSERT`, `UPDATE`, `DELETE`）。
     - 操作対象のテーブル名。

4. **結果の保存**:
   - JSON形式：階層構造を保持して保存。
   - CSV形式：フラットな形式で保存。

---

### **2. データ設計**

#### **2.1 JSON形式**
階層構造を保持した形式：

```json
[
  {
    "namespace": "com.example.mapper.UserMapper",
    "tags": [
      {
        "tag_id": "selectUserById",
        "sql_type": "SELECT",
        "tables": ["users"]
      },
      {
        "tag_id": "insertUser",
        "sql_type": "INSERT",
        "tables": ["users"]
      }
    ]
  }
]
```

#### **2.2 CSV形式**
フラットな形式で保存：

| namespace                     | tag_id            | sql_type | tables    |
|-------------------------------|-------------------|----------|-----------|
| com.example.mapper.UserMapper | selectUserById    | SELECT   | users     |
| com.example.mapper.UserMapper | insertUser        | INSERT   | users     |

---

### **3. 処理設計**

#### **3.1 XMLファイルの読み込み**
- 指定ディレクトリ内のすべてのXMLファイルを対象とする。
- Pythonの`glob`モジュールを使用してXMLファイルを収集。

#### **3.2 XMLの解析**
- **ライブラリ**:
  - Pythonの`xml.etree.ElementTree`または`lxml`を使用。
- **解析対象**:
  - `mapper`タグの`namespace`属性。
  - `<select>`、`<insert>`、`<update>`、`<delete>`タグの`id`属性とSQL文。

#### **3.3 SQL解析**
- **ライブラリ**:
  - SQL解析には`sqlparse`を使用。
- **解析内容**:
  - SQLの種類（`SELECT`, `INSERT`, `UPDATE`, `DELETE`）を判定。
  - テーブル名を抽出。
    - 正規表現を用いて`FROM`、`INTO`、`UPDATE`などのキーワードを解析。

---

### **4. 実装の流れ**

以下にPythonでの実装例を示します：

#### **4.1 XMLファイルの収集**

```python
import glob

# MyBatis XMLファイルの収集
xml_files = glob.glob("path/to/mapper/**/*.xml", recursive=True)
```

---

#### **4.2 XMLの解析**

```python
import xml.etree.ElementTree as ET

# XMLファイルの解析
def parse_mybatis_xml(file_path):
    tree = ET.parse(file_path)
    root = tree.getroot()

    # namespace取得
    namespace = root.attrib.get("namespace", "unknown")

    # タグ情報の収集
    tags = []
    for tag in root.findall(".//select") + root.findall(".//insert") + root.findall(".//update") + root.findall(".//delete"):
        tag_id = tag.attrib.get("id", "unknown")
        sql = "".join(tag.itertext()).strip()  # SQL文
        tags.append({"tag_id": tag_id, "sql": sql})

    return namespace, tags
```

---

#### **4.3 SQLの解析**

```python
import sqlparse
import re

# SQL解析
def analyze_sql(sql):
    parsed = sqlparse.parse(sql)[0]
    sql_type = parsed.token_first(skip_cm=True).value.upper()

    # テーブル名の抽出（簡易版）
    table_pattern = re.compile(r"(FROM|INTO|UPDATE)\s+([a-zA-Z0-9_]+)", re.IGNORECASE)
    tables = [match.group(2) for match in table_pattern.finditer(sql)]

    return sql_type, tables
```

---

#### **4.4 結果の保存**

```python
import json
import pandas as pd

results = []

# XML解析とSQL解析の統合
for file_path in xml_files:
    namespace, tags = parse_mybatis_xml(file_path)
    for tag in tags:
        sql_type, tables = analyze_sql(tag["sql"])
        results.append({
            "namespace": namespace,
            "tag_id": tag["tag_id"],
            "sql_type": sql_type,
            "tables": tables
        })

# JSON形式で保存
with open("mybatis_analysis.json", "w") as json_file:
    json.dump(results, json_file, indent=4)

# CSV形式で保存
df = pd.DataFrame(results)
df.to_csv("mybatis_analysis.csv", index=False)
```

---

### **5. 結果の見方**

#### **JSON形式**
- `namespace`単位で`tag_id`と`SQL`内容を整理。
- 階層構造を保持して関連性を把握しやすくする。

#### **CSV形式**
- 各行が1つの`tag_id`に対応。
- フラットな形式でフィルタリングや検索が容易。

---

### **6. システムの拡張性**
- **多テーブル操作**:
  - サブクエリや結合（`JOIN`）に対応した高度なSQL解析を導入。
- **可視化ツール**:
  - テーブル依存関係をグラフで表現。
- **他のSQL形式のサポート**:
  - MyBatis以外のORM（例: Hibernate）の解析ロジックを追加。

この設計に基づいて実装を進

めることで、MyBatisの依存関係とSQL操作を効率的に解析できます。必要に応じてさらに詳細な設計を追加しますので、お知らせください！