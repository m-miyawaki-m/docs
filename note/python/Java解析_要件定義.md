以下に、要件定義と基本設計を記述します。

---

## **要件定義**

### **1. 背景**
Javaプロジェクトのビジネスロジック層からDAO層までの呼び出し関係を解析し、MyBatisで使用されるSQLクエリ（`namespace.tag id`）を特定する必要がある。これにより、以下の目的を達成する：
- コードの依存関係を明確化する。
- SQL実行の追跡と影響範囲の特定を容易にする。
- メンテナンス性とリファクタリング効率を向上させる。

---

### **2. 要件**

#### **2.1 機能要件**
1. **呼び出し経路の解析**:
   - ビジネスロジック層のすべてのメソッドを起点に、`Util`層、`DAO`層、そしてMyBatisでのSQL実行までの呼び出し関係をトレース。
   - 再帰的にすべての呼び出しを解析。

2. **解析結果の保存**:
   - 以下の項目をJSONおよびCSV形式で出力：
     - 呼び出し元クラスとメソッド
     - 呼び出し先クラスとメソッド
     - 呼び出しの深さ（階層構造）
     - SQL実行時の`namespace`と`tag id`
     - 呼び出し元コードの行番号

3. **複数経路への対応**:
   - メソッド内で複数の`Util`クラスを呼び出す場合。
   - 異なるビジネスロジックメソッドから同じ`Util`クラスや`DAO`クラスが呼ばれる場合。

4. **階層構造の保持**:
   - 呼び出しの深さを記録して、呼び出し経路の階層構造を明確にする。

#### **2.2 非機能要件**
1. **解析の効率性**:
   - 大規模なプロジェクトでも実行可能な性能を確保。
   - 呼び出し経路の解析にかかる時間を10分以内に収める（中規模プロジェクト基準）。
2. **拡張性**:
   - 他のSQL実行方法（例: Hibernateなど）にも対応できる設計。
3. **視覚化の準備**:
   - 解析結果を他のツール（例: グラフ可視化ツール）で利用できる形式で保存。

---

## **基本設計**

### **1. システム構成**

#### **1.1 主な構成要素**
- **入力**:
  - Javaプロジェクトのソースコード（ディレクトリ）。
- **解析エンジン**:
  - JavaParserライブラリを使用してAST（抽象構文木）を生成し、呼び出し関係を解析。
- **出力**:
  - JSONファイル（階層構造を保存）
  - CSVファイル（フラットなリスト形式）

---

#### **1.2 フロー**
1. **ビジネスロジック層の解析**:
   - プロジェクト内のすべてのビジネスロジッククラスを取得。
   - 各メソッドを起点に呼び出しチェーンをトレース。

2. **呼び出しのトレース**:
   - 再帰的に呼び出しを追跡し、以下を記録：
     - 呼び出し元クラス・メソッド
     - 呼び出し先クラス・メソッド
     - 呼び出しの深さ（階層）

3. **SQL実行箇所の特定**:
   - `SqlSession`の`selectOne`, `insert`, `update`, `delete`メソッドを検出。
   - SQL実行時の引数（`namespace.tag id`）を抽出。

4. **結果の保存**:
   - JSON形式：階層構造を保持したまま保存。
   - CSV形式：1行ごとの呼び出し記録を保存。

---

### **2. データ設計**

#### **2.1 JSON形式**
階層構造を保持：

```json
[
  {
    "class": "BusinessLogic",
    "method": "methodA",
    "type": "method",
    "depth": 0,
    "line": 3,
    "children": [
      {
        "class": "UtilClass1",
        "method": "doSomething",
        "type": "method",
        "depth": 1,
        "line": 4,
        "children": []
      },
      {
        "class": "UtilClass2",
        "method": "performAction",
        "type": "method",
        "depth": 1,
        "line": 5,
        "children": []
      }
    ]
  }
]
```

#### **2.2 CSV形式**
フラットな形式：

| class          | method       | type   | query                        | line | depth |
|-----------------|-------------|--------|------------------------------|------|-------|
| BusinessLogic  | methodA     | method |                              | 3    | 0     |
| UtilClass1     | doSomething | method |                              | 4    | 1     |
| UtilClass2     | performAction | method |                              | 5    | 1     |

---

### **3. 処理設計**

#### **3.1 メソッド呼び出しチェーンのトレース**
- 再帰的な関数で深さを記録しながら解析。
- `SqlSession`呼び出しを検出し、特定の`query`値を記録。

#### **3.2 入力処理**
- プロジェクト内のすべてのJavaクラスを解析対象とする。
- JavaParserでASTを生成し、`MethodDeclaration`から呼び出しを取得。

#### **3.3 出力処理**
- JSON形式では階層構造を保持。
- CSV形式ではフラット化して保存。

---

### **4. 例外処理**
1. **未解決の呼び出し**:
   - 呼び出し先のメソッドが解決できない場合は、`unknown`として記録。
2. **SQL以外のメソッド呼び出し**:
   - 対象外の呼び出しは階層構造にのみ記録。

---

### **5. ツールとライブラリ**

#### **5.1 使用ライブラリ**
- **JavaParser**:
  - Javaコードの解析（AST生成と操作）。
- **JPype**:
  - JavaライブラリをPythonから利用。
- **Pandas**:
  - CSVファイルの生成。

#### **5.2 開発環境**
- **Python**: 解析スクリプトの実装。
- **Java**: ソースコードの解析対象。

---

### **6. システムの拡張性**
1. **他のORMのサポート**:
   - HibernateやJPAの解析ロジックを追加可能。
2. **可視化ツールとの連携**:
   - 解析結果をグラフ化するためのJSONエクスポート。

---

