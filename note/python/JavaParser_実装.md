複数の呼び出し経路が存在する場合、**呼び出しチェーンを完全にトレース**することが必要です。そのために、以下のアプローチを採用して対応できます。

---

### **アプローチの概要**

1. **呼び出しチェーンを再帰的に解析する**:
   - ビジネスロジックから開始し、メソッド呼び出しを辿る。
   - `getBean`やファクトリークラスで作成されたオブジェクトのメソッドもトレース。
   - 静的メソッド呼び出しや別の`Util`クラスへの移動も解析。

2. **呼び出し履歴を記録して解析結果に保存**:
   - 各ステップで、呼び出し元クラス・メソッドと呼び出し先クラス・メソッドを記録。
   - `SqlSession`の呼び出しに到達したら、`namespace`と`tag id`を抽出。

3. **結果をフラットなリスト形式で保存**:
   - ビジネスロジック -> ファクトリー -> Util -> DAO -> SQL という経路をリスト化し、CSVやJSONに保存。

---

### **解析の流れをコードに実装**

以下に、この複雑な経路を解析するPythonスクリプトを示します。

#### **1. 再帰的に呼び出しをトレースする関数**

```python
def trace_method_calls(method, current_chain):
    """
    再帰的にメソッド呼び出しを追跡する関数
    - method: 解析対象のメソッドノード
    - current_chain: 現在の呼び出しチェーンを記録するリスト
    """
    from com.github.javaparser.ast.expr import MethodCallExpr

    method_name = method.getNameAsString()
    class_name = method.getParentNode().get().getNameAsString()

    # 現在のメソッドを呼び出しチェーンに追加
    current_chain.append({"class": class_name, "method": method_name})

    # メソッド呼び出しを取得
    method_calls = method.findAll(MethodCallExpr)
    for call in method_calls:
        scope = call.getScope().orElse(None)
        called_method_name = call.getNameAsString()
        line = call.getRange().get().begin.line

        # 呼び出し元スコープを確認
        scope_name = str(scope) if scope else "static"

        # SqlSession呼び出しを検出
        if "selectOne" in called_method_name or "insert" in called_method_name or "update" in called_method_name or "delete" in called_method_name:
            args = call.getArguments()
            if args and len(args) > 0:
                mybatis_query = args[0].toString()
                current_chain.append({
                    "class": class_name,
                    "method": called_method_name,
                    "type": "sql",
                    "query": mybatis_query.strip('"'),
                    "line": line
                })
            continue

        # 別のメソッド呼び出しを再帰的に追跡
        next_method = call.resolve()
        if next_method:
            trace_method_calls(next_method, current_chain)
```

---

#### **2. 呼び出しの開始地点から解析をスタート**

```python
# ビジネスロジッククラスの開始メソッドを取得
from com.github.javaparser.ast.body import MethodDeclaration

parsed_data = []

methods = compilation_unit.findAll(MethodDeclaration)
for method in methods:
    if method.getNameAsString() == "process":  # 解析開始メソッド
        current_chain = []
        trace_method_calls(method, current_chain)

        # 呼び出しチェーンを記録
        parsed_data.append(current_chain)
```

---

#### **3. 出力結果を保存**

呼び出しチェーンをCSVまたはJSON形式で保存します。

```python
import pandas as pd
import json

# 呼び出しチェーンをフラットな形式に変換
flat_data = []
for chain in parsed_data:
    for step in chain:
        flat_data.append({
            "class": step.get("class", ""),
            "method": step.get("method", ""),
            "type": step.get("type", "method"),
            "query": step.get("query", ""),
            "line": step.get("line", "")
        })

# JSON形式で保存
with open("call_chain.json", "w") as json_file:
    json.dump(flat_data, json_file, indent=4)

# CSV形式で保存
df = pd.DataFrame(flat_data)
df.to_csv("call_chain.csv", index=False)
```

---

#### **4. 出力結果例**

**JSON**:

```json
[
    {"class": "BusinessLogic", "method": "process", "type": "method", "query": "", "line": 3},
    {"class": "UtilClass", "method": "doUtility", "type": "method", "query": "", "line": 6},
    {"class": "DaoClass", "method": "getData", "type": "method", "query": "", "line": 10},
    {"class": "DaoClass", "method": "selectOne", "type": "sql", "query": "exampleNamespace.exampleId", "line": 11}
]
```

**CSV**:

| class          | method       | type   | query                        | line |
|-----------------|-------------|--------|------------------------------|------|
| BusinessLogic  | process     | method |                              | 3    |
| UtilClass      | doUtility   | method |                              | 6    |
| DaoClass       | getData     | method |                              | 10   |
| DaoClass       | selectOne   | sql    | exampleNamespace.exampleId   | 11   |

---

### **5. 特殊ケースへの対応**

#### **5.1 `getBean`やファクトリーでの生成**
`getBean`のようなファクトリーメソッドを検出した場合は、その戻り値の型から呼び出されるメソッドを特定します。

```python
# 例: getBeanからの戻り値型を解析
return_type = call.resolve().getReturnType()
if return_type:
    trace_method_calls(return_type.getMethods(), current_chain)
```

---

#### **5.2 静的メソッドの解析**
静的メソッド呼び出しの場合も、`resolve()`を使って直接解析します。

---

### **6. このアプローチのメリット**
1. **再帰的トレース**:
   - ビジネスロジックから始まり、`Util`や`DAO`への呼び出し、SQL実行まで全経路を網羅的に解析。
2. **出力形式の統一**:
   - JSONやCSVに保存し、他ツールとの連携が容易。
3. **多様な経路への対応**:
   - ファクトリーパターンや静的メソッドも解析可能。

この仕組みを活用することで、複雑な呼び出しチェーンを効率的に解析できます！


### **複雑な呼び出し構造の解析の実装**

以下に、複数のビジネスロジックメソッド、複数の`Util`クラス、そして異なる深さを持つ`DAO`への呼び出しを解析する実装を整理します。

---

### **1. 実装の目的**

- **ビジネスロジックのすべてのメソッドを解析**。
- **メソッド内で呼び出されている`Util`クラスや`DAO`クラスをトレース**。
- **深さに応じた呼び出しの階層構造を解析**。
- **最終的に`SqlSession`の実行内容（MyBatisの`namespace`と`tag id`）を特定**。
- **解析結果をJSONやCSV形式で保存**して、後から参照可能に。

---

### **2. 実装手順**

#### **2.1 再帰的な呼び出しチェーントレースの設計**

以下の関数を中心に構成します。

- **`trace_method_calls`**:
  - メソッドを再帰的に解析。
  - メソッド内の呼び出し先を階層構造で記録。
  - `SqlSession`のSQL実行を特定して保存。

#### **2.2 トップレベルメソッドから解析開始**

- ビジネスロジッククラス内のすべてのメソッドを取得し、それぞれについて`trace_method_calls`を呼び出します。

#### **2.3 解析結果を保存**

- 結果をフラットな形式（JSONやCSV）に変換。
- 呼び出し経路を階層的に保持しつつ、必要に応じてデータをフィルタリング可能に。

---

### **3. 実装コード**

```python
import json
import pandas as pd
from jpype import startJVM, shutdownJVM
from jpype.types import JString
from com.github.javaparser import JavaParser
from com.github.javaparser.ast.body import MethodDeclaration
from com.github.javaparser.ast.expr import MethodCallExpr

# JVMの起動
startJVM(classpath=["path/to/javaparser-core-3.25.4.jar"])

# サンプルJavaコード
java_code = """
public class BusinessLogic {
    public void methodA() {
        UtilClass1.doSomething();
        UtilClass2.performAction();
    }

    public void methodB() {
        UtilClass1.doSomething();
        DaoClass dao = new DaoClass();
        dao.getData("exampleNamespace.exampleId");
    }
}

public class UtilClass1 {
    public static void doSomething() {
        System.out.println("UtilClass1 doing something");
    }
}

public class UtilClass2 {
    public static void performAction() {
        System.out.println("UtilClass2 performing action");
    }
}

public class DaoClass {
    private SqlSession sqlSession;

    public DaoClass() {
        this.sqlSession = MyBatisUtil.getSqlSession();
    }

    public Object getData(String query) {
        return sqlSession.selectOne(query);
    }
}
"""

# メソッド呼び出しを再帰的にトレース
def trace_method_calls(method, current_chain, depth=0):
    method_name = method.getNameAsString()
    class_name = method.getParentNode().get().getNameAsString()

    # 現在のメソッドを記録
    current_chain.append({
        "class": class_name,
        "method": method_name,
        "type": "method",
        "depth": depth,
        "line": method.getRange().get().begin.line
    })

    # メソッド呼び出しを解析
    method_calls = method.findAll(MethodCallExpr)
    for call in method_calls:
        scope = call.getScope().orElse(None)
        called_method_name = call.getNameAsString()
        line = call.getRange().get().begin.line

        # SqlSession呼び出しを検出
        if "selectOne" in called_method_name:
            args = call.getArguments()
            if args and len(args) > 0:
                query = args[0].toString()
                current_chain.append({
                    "class": class_name,
                    "method": called_method_name,
                    "type": "sql",
                    "depth": depth + 1,
                    "line": line,
                    "query": query.strip('"')
                })
            continue

        # 再帰的に呼び出しを追跡
        trace_method_calls(call.resolve(), current_chain, depth + 1)

# Javaコードを解析
parser = JavaParser()
result = parser.parse(JString(java_code))
compilation_unit = result.getResult().get()

# ビジネスロジッククラスのすべてのメソッドを解析
parsed_data = []
methods = compilation_unit.findAll(MethodDeclaration)
for method in methods:
    current_chain = []
    trace_method_calls(method, current_chain)
    parsed_data.append(current_chain)

# 呼び出しチェーンをフラットな形式に変換
flat_data = []
for chain in parsed_data:
    for step in chain:
        flat_data.append({
            "class": step["class"],
            "method": step["method"],
            "type": step["type"],
            "query": step.get("query", ""),
            "line": step["line"],
            "depth": step["depth"]
        })

# JSON形式で保存
with open("call_chain.json", "w") as json_file:
    json.dump(flat_data, json_file, indent=4)

# CSV形式で保存
df = pd.DataFrame(flat_data)
df.to_csv("call_chain.csv", index=False)

# JVMの終了
shutdownJVM()
```

---

### **4. 出力結果の見方**

#### **JSON形式**

```json
[
    {"class": "BusinessLogic", "method": "methodA", "type": "method", "depth": 0, "line": 3},
    {"class": "UtilClass1", "method": "doSomething", "type": "method", "depth": 1, "line": 4},
    {"class": "UtilClass2", "method": "performAction", "type": "method", "depth": 1, "line": 5},
    {"class": "BusinessLogic", "method": "methodB", "type": "method", "depth": 0, "line": 7},
    {"class": "UtilClass1", "method": "doSomething", "type": "method", "depth": 1, "line": 8},
    {"class": "DaoClass", "method": "getData", "type": "method", "depth": 1, "line": 9},
    {"class": "DaoClass", "method": "selectOne", "type": "sql", "query": "exampleNamespace.exampleId", "depth": 2, "line": 10}
]
```

#### **CSV形式**

| class          | method       | type   | query                        | line | depth |
|-----------------|-------------|--------|------------------------------|------|-------|
| BusinessLogic  | methodA     | method |                              | 3    | 0     |
| UtilClass1     | doSomething | method |                              | 4    | 1     |
| UtilClass2     | performAction | method |                              | 5    | 1     |
| BusinessLogic  | methodB     | method |                              | 7    | 0     |
| UtilClass1     | doSomething | method |                              | 8    | 1     |
| DaoClass       | getData     | method |                              | 9    | 1     |
| DaoClass       | selectOne   | sql    | exampleNamespace.exampleId   | 10   | 2     |

---

### **5. 結論と活用法**

#### **5.1 実装のポイント**
- 各メソッドを起点に再帰的に解析し、呼び出し経路を階層的に記録。
- 呼び出しの深さ（`depth`）を追跡し、階層構造を明確化。
- SQL実行の内容（`namespace.tag id`）を特定し、記録。

#### **5.2 活用方法**
- **依存関係の可視化**: 呼び出し経路をトレースして、`Util`や`DAO`の利用箇所を分析。
- **MyBatisの`namespace`特定**: `SqlSession`の実行箇所から`namespace`と`tag id`を把握。
- **メンテナンス性向上**: 複雑な呼び出しチェーンを理解してリファクタリングを支援。

この仕組みによって、大規模なコードベースでも効率的に呼び出し関係を解析できます！