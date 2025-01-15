Python の `re` ライブラリは、正規表現を使用して文字列を操作するためのライブラリです。以下に `re` ライブラリの基本的な使い方と文法をまとめます。

---

## **1. 基本的な使い方**

### 正規表現のコンパイルと使用
```python
import re

# 正規表現をコンパイル
pattern = re.compile(r'\d+')  # 数字にマッチする正規表現

# マッチを検索
result = pattern.search('abc123def')
if result:
    print(result.group())  # 123
```

`re.compile` を使わなくても直接 `re` モジュールの関数を利用可能。

```python
result = re.search(r'\d+', 'abc123def')
print(result.group())  # 123
```

---

## **2. 主な関数**

### `re.search()`
- **目的**: 文字列全体を検索し、最初にマッチしたものを返す。
- **例**:
```python
match = re.search(r'\d+', 'abc123def456')
print(match.group())  # 123
```

### `re.match()`
- **目的**: 文字列の先頭からマッチするかを確認。
- **例**:
```python
match = re.match(r'\d+', '123abc')
print(match.group())  # 123
```
```python
match = re.match(r'\d+', 'abc123')
print(match)  # None
```

### `re.findall()`
- **目的**: マッチするすべての部分文字列をリストで返す。
- **例**:
```python
matches = re.findall(r'\d+', 'abc123def456ghi789')
print(matches)  # ['123', '456', '789']
```

### `re.finditer()`
- **目的**: マッチする部分文字列を `Match` オブジェクトのイテレータとして返す。
- **例**:
```python
for match in re.finditer(r'\d+', 'abc123def456'):
    print(match.group())  # 123, 456
```

### `re.sub()`
- **目的**: 正規表現に一致した部分文字列を置換する。
- **例**:
```python
result = re.sub(r'\d+', 'NUMBER', 'abc123def456')
print(result)  # abcNUMBERdefNUMBER
```

### `re.split()`
- **目的**: 正規表現に一致した部分で文字列を分割する。
- **例**:
```python
result = re.split(r'\d+', 'abc123def456ghi')
print(result)  # ['abc', 'def', 'ghi']
```

---

## **3. よく使う正規表現のパターン**

| 正規表現       | 説明                                           | 例                        |
|----------------|------------------------------------------------|---------------------------|
| `.`            | 任意の1文字                                    | `a.c` → `abc`, `a1c`      |
| `\d`           | 数字 (0-9)                                     | `\d+` → `123`, `456`      |
| `\w`           | 英数字またはアンダースコア (`[a-zA-Z0-9_]`)     | `\w+` → `abc123`          |
| `\s`           | 空白文字 (スペース, タブ, 改行)                 | `\s+` → スペース区切り     |
| `^`            | 行の先頭                                       | `^abc` → `abc123`         |
| `$`            | 行の末尾                                       | `123$` → `abc123`         |
| `*`            | 0回以上の繰り返し                              | `a*` → `aaa`, `a`         |
| `+`            | 1回以上の繰り返し                              | `a+` → `aaa`, `a`         |
| `?`            | 0回または1回の出現                             | `a?` → `a`, 空文字         |
| `{n,m}`        | n回以上m回以下の繰り返し                       | `a{2,3}` → `aa`, `aaa`    |
| `|`            | OR条件                                         | `a|b` → `a`, `b`          |
| `( )`          | グループ化                                     | `(abc)+` → `abcabc`       |
| `\[ \]`        | 文字クラス                                     | `[abc]` → `a`, `b`, `c`   |
| `[^ ]`         | 否定                                           | `[^abc]` → `d`, `e`       |
| `\`            | エスケープ文字                                 | `\\` → `\`                |

---

## **4. フラグ (オプション)**

| フラグ           | 説明                                       |
|------------------|--------------------------------------------|
| `re.IGNORECASE` (`re.I`) | 大文字小文字を区別しない               |
| `re.MULTILINE` (`re.M`)  | 複数行モード (`^`と`$`が行ごとに動作) |
| `re.DOTALL` (`re.S`)     | `.`が改行文字にもマッチする           |
| `re.VERBOSE` (`re.X`)    | 正規表現を可読形式で記述できる       |

### フラグの例

```python
text = "Hello World\nHELLO WORLD"

# IGNORECASE
matches = re.findall(r'hello', text, re.IGNORECASE)
print(matches)  # ['Hello', 'HELLO']

# DOTALL
match = re.search(r'Hello.*World', text, re.DOTALL)
print(match.group())  # Hello World\nHELLO WORLD
```

---

## **5. 便利な正規表現の例**

1. **メールアドレスの検出**
    ```python
    email = "example@example.com"
    match = re.match(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}', email)
    print(match.group())  # example@example.com
    ```

2. **電話番号の検出**
    ```python
    phone = "123-456-7890"
    match = re.match(r'\d{3}-\d{3}-\d{4}', phone)
    print(match.group())  # 123-456-7890
    ```

3. **HTMLタグの抽出**
    ```python
    html = "<h1>Title</h1>"
    match = re.search(r'<(.*?)>(.*?)</\1>', html)
    print(match.groups())  # ('h1', 'Title')
    ```

---

## **6. 注意点**
- 特殊文字 (`.`, `*`, `+` など) はエスケープが必要。
    ```python
    re.search(r'\.', 'a.b')  # ドットを文字として扱う
    ```

- 複雑な正規表現では `re.VERBOSE` を活用して読みやすくする。

---

これで `re` ライブラリの基本的な使い方と文法は以上です！正規表現は強力なツールなので、少しずつ習得してみてください。

Java のコード解析において、`re` ライブラリを使用して特定の構文や要素を抽出する場合、以下のような正規表現を使用することができます。これらの正規表現は、Java の基本構文を解析するためのサンプルです。

---

## **1. コメントの抽出**
### シングルラインコメント (`//`)
```regex
//.*$
```

### マルチラインコメント (`/* ... */`)
```regex
/\*.*?\*/
```

### 両方を同時に抽出
```regex
//.*$|/\*.*?\*/
```

---

## **2. パッケージ宣言**
### `package` 宣言の検出
```regex
package\s+([a-zA-Z_][a-zA-Z0-9_.]*);?
```
- **例**: `package com.example.myapp;`
- **キャプチャ結果**: `com.example.myapp`

---

## **3. インポート文**
### `import` 文の検出
```regex
import\s+(static\s+)?([a-zA-Z_][a-zA-Z0-9_.]*\*?);?
```
- **例**: 
  - `import java.util.List;`
  - `import static java.util.Collections.*;`
- **キャプチャ結果**: 
  - `java.util.List`
  - `static java.util.Collections.*`

---

## **4. クラス宣言**
### クラス名を含む宣言の検出
```regex
public\s+class\s+([a-zA-Z_][a-zA-Z0-9_]*)\s*(extends\s+[a-zA-Z_][a-zA-Z0-9_]*(\s*,\s*[a-zA-Z_][a-zA-Z0-9_]*)*)?\s*(implements\s+[a-zA-Z_][a-zA-Z0-9_]*(\s*,\s*[a-zA-Z_][a-zA-Z0-9_]*)*)?\s*{
```
- **例**:
  - `public class MyClass extends BaseClass implements Interface1, Interface2 {`
  - **キャプチャ結果**: `MyClass`

---

## **5. メソッド宣言**
### メソッドの検出（引数と戻り値を含む）
```regex
(public|protected|private|static|final|native|synchronized|abstract|default|strictfp)?\s*([a-zA-Z_][a-zA-Z0-9_<>[\]]*\s+)+([a-zA-Z_][a-zA-Z0-9_]*)\s*\((.*?)\)\s*(throws\s+[a-zA-Z_][a-zA-Z0-9_]*(\s*,\s*[a-zA-Z_][a-zA-Z0-9_]*)*)?\s*{?
```
- **例**:
  - `public static void main(String[] args) throws Exception {`
  - **キャプチャ結果**: 
    - 戻り値: `void`
    - メソッド名: `main`
    - 引数: `String[] args`

---

## **6. 変数宣言**
### ローカル変数やフィールドの検出
```regex
([a-zA-Z_][a-zA-Z0-9_<>[\]]+)\s+([a-zA-Z_][a-zA-Z0-9_]*)\s*(=\s*[^;]*)?;
```
- **例**:
  - `int count = 10;`
  - `String name;`
- **キャプチャ結果**:
  - 型: `int`, `String`
  - 変数名: `count`, `name`
  - 初期値 (オプション): `10`, `None`

---

## **7. `if` 文の検出**
### `if` 文の条件を抽出
```regex
if\s*\((.*?)\)\s*{?
```
- **例**: 
  - `if (x > 0) {`
  - **キャプチャ結果**: `x > 0`

---

## **8. ループ構文**
### `for` 文の検出
```regex
for\s*\((.*?);(.*?);(.*?)\)\s*{?
```
- **例**: 
  - `for (int i = 0; i < 10; i++) {`
  - **キャプチャ結果**: 
    - 初期化: `int i = 0`
    - 条件: `i < 10`
    - 更新: `i++`

### 拡張 `for` 文 (`for-each`)
```regex
for\s*\((.*?)\s+:\s+(.*?)\)\s*{?
```
- **例**:
  - `for (String item : list) {`
  - **キャプチャ結果**: 
    - 型と変数: `String item`
    - コレクション: `list`

---

## **9. アノテーション**
### アノテーションの検出
```regex
@\s*([a-zA-Z_][a-zA-Z0-9_]*)(\((.*?)\))?
```
- **例**:
  - `@Override`
  - `@RequestMapping(value="/path", method=RequestMethod.GET)`
- **キャプチャ結果**: 
  - アノテーション名: `Override`, `RequestMapping`
  - 引数 (オプション): `value="/path", method=RequestMethod.GET`

---

## **10. リテラル**
### 文字列リテラル
```regex
"([^"\\]*(\\.[^"\\]*)*)"
```
- **例**: 
  - `"Hello, World!"`
  - `"This is \"escaped\""`
- **キャプチャ結果**: 
  - `Hello, World!`
  - `This is "escaped"`

### 数値リテラル
```regex
\d+(\.\d+)?([eE][+-]?\d+)?[fFdD]?
```
- **例**: 
  - `123`
  - `3.14`
  - `2e10`
- **キャプチャ結果**: `123`, `3.14`, `2e10`

---

## **11. `import static` 文の検出**
### 静的インポート
```regex
import\s+static\s+([a-zA-Z_][a-zA-Z0-9_.]*);
```
- **例**:
  - `import static java.util.Collections.sort;`
- **キャプチャ結果**: `java.util.Collections.sort`

---

## **12. プリミティブ型**
### プリミティブ型の検出
```regex
\b(boolean|byte|char|short|int|long|float|double)\b
```
- **例**:
  - `int`
  - `double`
- **キャプチャ結果**: `int`, `double`

---

## **13. `throws` 節の検出**
```regex
throws\s+([a-zA-Z_][a-zA-Z0-9_]*(\s*,\s*[a-zA-Z_][a-zA-Z0-9_]*)*)
```
- **例**:
  - `throws IOException, NullPointerException`
- **キャプチャ結果**: `IOException, NullPointerException`

---

## **14. クラスフィールドの検出**
### フィールド変数を抽出
```regex
(private|protected|public|static|final|transient|volatile)?\s+([a-zA-Z_][a-zA-Z0-9_<>[\]]+)\s+([a-zA-Z_][a-zA-Z0-9_]*)\s*(=\s*[^;]*)?;
```
- **例**:
  - `private static final int MAX_COUNT = 100;`
- **キャプチャ結果**:
  - 修飾子: `private static final`
  - 型: `int`
  - フィールド名: `MAX_COUNT`
  - 初期値: `100`

---

これらの正規表現を組み合わせることで、Java のソースコードの解析や解析ツールの作成が可能です。必要に応じて正規表現をカスタマイズしてください！