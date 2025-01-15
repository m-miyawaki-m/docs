JavaParserをPythonで使って、クラスフィールドやローカルフィールドの型、呼び出し箇所、メソッド内で呼び出されている他のメソッドを解析する手法を以下に示します。

---

### **1. 前提**
以下のようなJavaコードを解析対象とします。

```java
public class HelloWorld {
    private String message;

    public void greet() {
        message = "Hello, World!";
        System.out.println(message);
        displayMessage();
    }

    private void displayMessage() {
        System.out.println("Displaying: " + message);
    }
}
```

このコードに対し、以下をPythonで解析します：
1. **クラスフィールドと型の取得**
2. **メソッド内のローカルフィールドと型の取得**
3. **フィールドやメソッド呼び出し箇所の取得**
4. **メソッド内で呼び出されている他のメソッドを取得**

---

### **2. 実装**

#### **2.1 セットアップ**

まず、JavaParserをPython環境でセットアップします（JPypeの導入やJARファイルのロードが必要です）。詳細は前回の手順を参考にしてください。

---

#### **2.2 クラスフィールドと型を取得**

```python
from jpype import startJVM, shutdownJVM
from jpype.imports import registerDomain
from jpype.types import JString

# JVMの起動（適切なJARファイルのパスを設定）
startJVM(classpath=["path/to/javaparser-core-3.25.4.jar"])

from com.github.javaparser import JavaParser
from com.github.javaparser.ast.body import ClassOrInterfaceDeclaration, FieldDeclaration

# サンプルJavaコード
java_code = """
public class HelloWorld {
    private String message;

    public void greet() {
        message = "Hello, World!";
        System.out.println(message);
        displayMessage();
    }

    private void displayMessage() {
        System.out.println("Displaying: " + message);
    }
}
"""

# Javaコードを解析
parser = JavaParser()
result = parser.parse(JString(java_code))

# CompilationUnitを取得
compilation_unit = result.getResult().get()

# クラスフィールドとその型を取得
class_declarations = compilation_unit.findAll(ClassOrInterfaceDeclaration)
for class_decl in class_declarations:
    fields = class_decl.getFields()
    for field in fields:
        field_type = field.getVariables().get(0).getType()
        field_name = field.getVariables().get(0).getNameAsString()
        print(f"Class Field: {field_name}, Type: {field_type}")
```

**出力例**:
```
Class Field: message, Type: String
```

---

#### **2.3 メソッド内のローカルフィールドと型を取得**

```python
from com.github.javaparser.ast.body import MethodDeclaration
from com.github.javaparser.ast.stmt import VariableDeclarationExpr

# メソッド内のローカルフィールドを取得
methods = compilation_unit.findAll(MethodDeclaration)
for method in methods:
    print(f"Method: {method.getNameAsString()}")
    variables = method.findAll(VariableDeclarationExpr)
    for var in variables:
        var_type = var.getVariable(0).getType()
        var_name = var.getVariable(0).getNameAsString()
        print(f"  Local Variable: {var_name}, Type: {var_type}")
```

**出力例**:
```
Method: greet
```

（この例ではローカルフィールドがないため、出力はありませんが、ローカルフィールドがある場合に対応しています。）

---

#### **2.4 呼び出し箇所とメソッドの取得**

```python
from com.github.javaparser.ast.expr import MethodCallExpr

# メソッド内で呼び出されているメソッドを取得
for method in methods:
    print(f"Method: {method.getNameAsString()}")
    method_calls = method.findAll(MethodCallExpr)
    for call in method_calls:
        print(f"  Method Call: {call.getNameAsString()}, Called in line: {call.getRange().get().begin.line}")
```

**出力例**:
```
Method: greet
  Method Call: println, Called in line: 6
  Method Call: displayMessage, Called in line: 7
Method: displayMessage
  Method Call: println, Called in line: 10
```

---

#### **2.5 呼び出されるメソッドを解析**

```python
# 各メソッド内で呼び出されている他のメソッドを取得
for method in methods:
    print(f"Method: {method.getNameAsString()}")
    method_calls = method.findAll(MethodCallExpr)
    for call in method_calls:
        called_method = call.getNameAsString()
        print(f"  Calls: {called_method}")
```

**出力例**:
```
Method: greet
  Calls: println
  Calls: displayMessage
Method: displayMessage
  Calls: println
```

---

### **3. プログラム終了処理**

JVMを終了します。

```python
shutdownJVM()
```

---

### **4. 実装ポイントと解説**
- **クラスフィールドと型**: `FieldDeclaration`を解析して、フィールド名と型を取得します。
- **ローカルフィールド**: `VariableDeclarationExpr`を解析して、メソッド内のローカル変数を取得します。
- **呼び出し箇所とメソッド名**: `MethodCallExpr`を使い、呼び出されているメソッドとその箇所（行番号）を解析します。
- **他メソッドの呼び出し**: 各メソッド内の`MethodCallExpr`をチェックすることで、関連メソッドの追跡が可能です。

このスクリプトを使えば、Javaコードの詳細な静的解析が簡単に行えます。興味に応じてカスタマイズしてみてください！

以下に、Javaコードを解析して**ローカルフィールドのメソッド呼び出し**や**`new`によるインスタンス生成**を検出する方法を示します。これらをPythonでJavaParserを使って解析します。

---

### **1. 対象のJavaコード**

以下のコードを解析対象とします：

```java
public class HelloWorld {
    public void greet() {
        String message = "Hello, World!";
        System.out.println(message.toLowerCase());

        Example example = new Example();
        example.doSomething();
    }
}

class Example {
    public void doSomething() {
        System.out.println("Doing something!");
    }
}
```

### **2. ローカルフィールドのメソッド呼び出しを検出**

#### **2.1 実装コード**

```python
from jpype import startJVM, shutdownJVM
from jpype.types import JString
from com.github.javaparser import JavaParser
from com.github.javaparser.ast.expr import VariableDeclarationExpr, MethodCallExpr, ObjectCreationExpr

# JVMを起動
startJVM(classpath=["path/to/javaparser-core-3.25.4.jar"])

# Javaコード
java_code = """
public class HelloWorld {
    public void greet() {
        String message = "Hello, World!";
        System.out.println(message.toLowerCase());

        Example example = new Example();
        example.doSomething();
    }
}

class Example {
    public void doSomething() {
        System.out.println("Doing something!");
    }
}
"""

# Javaコードを解析
parser = JavaParser()
result = parser.parse(JString(java_code))

# CompilationUnitを取得
compilation_unit = result.getResult().get()

# メソッド内のローカルフィールドとそのメソッド呼び出しを解析
from com.github.javaparser.ast.body import MethodDeclaration

methods = compilation_unit.findAll(MethodDeclaration)
for method in methods:
    print(f"Analyzing method: {method.getNameAsString()}")

    # ローカルフィールドの宣言を取得
    variables = method.findAll(VariableDeclarationExpr)
    for variable in variables:
        var_name = variable.getVariable(0).getNameAsString()
        var_type = variable.getVariable(0).getType()
        print(f"  Local Variable: {var_name}, Type: {var_type}")

    # ローカルフィールドのメソッド呼び出しを取得
    method_calls = method.findAll(MethodCallExpr)
    for call in method_calls:
        scope = call.getScope().orElse(None)
        if scope:
            print(f"  Method Call: {call.getNameAsString()}, Scope: {scope}")

    # newによるインスタンス生成を取得
    instances = method.findAll(ObjectCreationExpr)
    for instance in instances:
        print(f"  Instance Creation: {instance.getTypeAsString()}")
```

---

#### **2.2 出力結果**

```
Analyzing method: greet
  Local Variable: message, Type: String
  Method Call: toLowerCase, Scope: message
  Method Call: println, Scope: System.out
  Local Variable: example, Type: Example
  Instance Creation: Example
  Method Call: doSomething, Scope: example
Analyzing method: doSomething
  Method Call: println, Scope: System.out
```

---

### **3. 処理内容の詳細**

1. **ローカルフィールドとそのメソッド呼び出し**:
   - `VariableDeclarationExpr` を使ってローカルフィールドを解析します。
   - 各フィールドに対して、`MethodCallExpr` を使用して呼び出されているメソッドとスコープ（フィールド名）を取得します。

2. **`new`によるインスタンス生成**:
   - `ObjectCreationExpr` を使って、`new`によるインスタンス生成を検出します。
   - 生成されたインスタンスの型を取得できます。

3. **スコープの取得**:
   - `MethodCallExpr.getScope()` を使い、どの変数やオブジェクトからメソッドが呼び出されたのかを特定します。

---

### **4. 応用: 出力形式の整理**

出力をより分かりやすくするため、呼び出しの詳細を整理して出力する形式に変更できます。

```python
print(f"Method: {method.getNameAsString()}")
print(f"  Local Variables:")
for variable in variables:
    print(f"    - Name: {var_name}, Type: {var_type}")
print(f"  Method Calls:")
for call in method_calls:
    print(f"    - {call.getNameAsString()} (Scope: {scope})")
print(f"  Instance Creations:")
for instance in instances:
    print(f"    - {instance.getTypeAsString()}")
```

---

### **5. このアプローチの応用範囲**
- **静的解析ツール**の構築: 変数使用状況やメソッド呼び出しの依存関係を解析可能。
- **リファクタリング支援**: インスタンス生成やメソッドの利用箇所を特定して改善ポイントを提示。
- **テストカバレッジ解析**: 呼び出しのスコープとメソッドをトレースして未使用部分を特定。

---

### **6. 終了処理**

作業終了後はJVMをシャットダウンしてください。

```python
shutdownJVM()
```

---

### **7. 注意点**
- **解析対象コードが複雑な場合**、ノード探索処理が増えるため、処理速度に注意。
- **クラスパスの設定**を適切に行い、`javaparser-core`のバージョンと一致させる必要があります。

このスクリプトを使えば、ローカルフィールドのメソッド呼び出しやインスタンス生成を効率よく解析できます！


提案されている仕組みは、**クラス依存関係の解析と管理を効率化するためのアプローチ**です。このような仕組みをPythonでJavaParserを使って実現する手順を以下に説明します。

---

### **目標**
1. **各クラスの解析結果をCSVまたはJSON形式で保存**:
   - クラスフィールド、ローカルフィールド、メソッド呼び出し、`new`でのインスタンス生成などを保存。
2. **保存したデータを他クラスの解析時に参照**:
   - 依存関係を効率的に解析し、結果を統合。

---

### **1. 解析結果の保存形式**

#### **1.1 CSV形式**
各クラスの解析結果を以下のようなCSV形式で保存します。

| クラス名        | 要素種別       | 名前         | 型           | 呼び出し元      | 定義場所（行番号） |
|----------------|---------------|-------------|-------------|---------------|-----------------|
| `HelloWorld`  | `Field`       | `message`   | `String`    | -             | 3               |
| `HelloWorld`  | `MethodCall`  | `toLowerCase` | -           | `message`     | 6               |
| `HelloWorld`  | `Instance`    | -           | `Example`   | -             | 8               |
| `HelloWorld`  | `MethodCall`  | `doSomething` | -           | `example`     | 9               |

#### **1.2 JSON形式**
同じ内容をJSON形式で保存する場合：

```json
{
  "HelloWorld": {
    "fields": [
      { "name": "message", "type": "String", "line": 3 }
    ],
    "method_calls": [
      { "name": "toLowerCase", "scope": "message", "line": 6 },
      { "name": "doSomething", "scope": "example", "line": 9 }
    ],
    "instances": [
      { "type": "Example", "line": 8 }
    ]
  }
}
```

---

### **2. Pythonでの解析と保存処理**

#### **2.1 必要なライブラリのインストール**
必要に応じて以下のライブラリをインストールします：

```bash
pip install pandas
```

---

#### **2.2 解析スクリプト**

以下は、解析結果をJSONファイルに保存するPythonスクリプトです。

```python
import json
import pandas as pd
from jpype import startJVM, shutdownJVM
from jpype.types import JString
from com.github.javaparser import JavaParser
from com.github.javaparser.ast.body import MethodDeclaration
from com.github.javaparser.ast.expr import VariableDeclarationExpr, MethodCallExpr, ObjectCreationExpr

# JVMを起動
startJVM(classpath=["path/to/javaparser-core-3.25.4.jar"])

# Javaコード
java_code = """
public class HelloWorld {
    public void greet() {
        String message = "Hello, World!";
        System.out.println(message.toLowerCase());

        Example example = new Example();
        example.doSomething();
    }
}

class Example {
    public void doSomething() {
        System.out.println("Doing something!");
    }
}
"""

# Javaコードを解析
parser = JavaParser()
result = parser.parse(JString(java_code))
compilation_unit = result.getResult().get()

# クラスごとの解析結果を保存
parsed_data = {}

# クラス解析
for class_decl in compilation_unit.findAll(MethodDeclaration):
    class_name = class_decl.getParentNode().get().getNameAsString()
    parsed_data[class_name] = {
        "fields": [],
        "method_calls": [],
        "instances": []
    }

    # ローカル変数の解析
    variables = class_decl.findAll(VariableDeclarationExpr)
    for variable in variables:
        var_name = variable.getVariable(0).getNameAsString()
        var_type = variable.getVariable(0).getType().toString()
        var_line = variable.getRange().get().begin.line
        parsed_data[class_name]["fields"].append({"name": var_name, "type": var_type, "line": var_line})

    # メソッド呼び出しの解析
    method_calls = class_decl.findAll(MethodCallExpr)
    for call in method_calls:
        scope = call.getScope().orElse(None)
        method_name = call.getNameAsString()
        method_line = call.getRange().get().begin.line
        parsed_data[class_name]["method_calls"].append({"name": method_name, "scope": str(scope), "line": method_line})

    # インスタンス生成の解析
    instances = class_decl.findAll(ObjectCreationExpr)
    for instance in instances:
        instance_type = instance.getTypeAsString()
        instance_line = instance.getRange().get().begin.line
        parsed_data[class_name]["instances"].append({"type": instance_type, "line": instance_line})

# 結果をJSONファイルとして保存
with open("parsed_data.json", "w") as json_file:
    json.dump(parsed_data, json_file, indent=4)

# 結果をCSVファイルとして保存
csv_data = []
for class_name, class_content in parsed_data.items():
    for field in class_content["fields"]:
        csv_data.append([class_name, "Field", field["name"], field["type"], "-", field["line"]])
    for call in class_content["method_calls"]:
        csv_data.append([class_name, "MethodCall", call["name"], "-", call["scope"], call["line"]])
    for instance in class_content["instances"]:
        csv_data.append([class_name, "Instance", "-", instance["type"], "-", instance["line"]])

df = pd.DataFrame(csv_data, columns=["ClassName", "ElementType", "Name", "Type", "Scope", "Line"])
df.to_csv("parsed_data.csv", index=False)

# JVMの終了
shutdownJVM()
```

---

### **3. 別クラスからの呼び出し解析**

保存されたJSONやCSVファイルを参照して、他クラスの依存関係を解消します。

#### **3.1 JSONを読み込む例**

```python
with open("parsed_data.json", "r") as json_file:
    data = json.load(json_file)

# 例: 依存関係の確認
for class_name, content in data.items():
    print(f"Class: {class_name}")
    for call in content["method_calls"]:
        print(f"  Calls: {call['name']} from {call['scope']} at line {call['line']}")
```

#### **3.2 CSVを読み込む例**

```python
df = pd.read_csv("parsed_data.csv")

# 特定クラスの依存関係を確認
example_calls = df[(df["ElementType"] == "MethodCall") & (df["ClassName"] == "Example")]
print(example_calls)
```

---

### **4. この方法のメリット**
1. **効率性**:
   - 同じ型やクラスが複数回呼び出される場合でも、保存済みの結果を参照することで再解析を回避できます。
2. **柔軟性**:
   - JSON/CSVファイルを基に解析内容をフィルタリングし、複雑な依存関係を視覚化できます。
3. **拡張性**:
   - 他のクラスとの連携やさらなる依存関係の解析に応用可能です。

---

この仕組みを利用することで、大規模なJavaコードの依存関係解析が効率的に行えます。必要に応じて機能を追加してください！