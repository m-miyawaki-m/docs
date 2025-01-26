### mypyとは

**mypy**は、Pythonコードの静的型チェックを行うツールです。  
Pythonは動的型付け言語ですが、**型ヒント**（Type Hints）を活用することで、mypyがコード中の型エラーを実行前に検出し、コードの安全性と信頼性を向上させます。

mypyは型チェックを行うだけで、実行時のコードには影響を与えません。そのため、動的型付け言語の利便性を維持しながら、静的型チェックの恩恵を受けられるのが特徴です。

---

### mypyの主な特徴

1. **型チェック**:
   - Pythonコード内の型ヒントを解析し、型の不一致やエラーを検出します。

2. **実行前にバグを発見**:
   - 静的解析により、実行時エラーを未然に防ぎます。

3. **PEP 484準拠**:
   - Pythonの型ヒント仕様（PEP 484、PEP 526、PEP 585など）に準拠。

4. **柔軟性**:
   - 型指定が無い部分は、デフォルトで`Any`型として扱うため、完全に型指定する必要はありません。

5. **部分的な適用**:
   - プロジェクトの一部だけに型ヒントを導入することも可能です。

---

### mypyのインストール

mypyはPythonパッケージとして提供されています。以下のコマンドでインストールできます：

```bash
pip install mypy
```

インストール後、バージョンを確認：

```bash
mypy --version
```

---

### mypyの基本的な使い方

1. **コードに型ヒントを追加**

   型ヒントを使用してコードを記述します。

   ```python
   def greet(name: str) -> str:
       return f"Hello, {name}"

   def add(a: int, b: int) -> int:
       return a + b
   ```

2. **mypyで型チェック**

   以下のコマンドでコードをチェックします：

   ```bash
   mypy script.py
   ```

   出力例（エラーが無い場合）：
   ```plaintext
   Success: no issues found in 1 source file
   ```

3. **エラーがある場合の出力**

   型が一致しない場合の例：

   ```python
   def add(a: int, b: int) -> int:
       return a + b

   result = add("10", 20)  # 型エラー
   ```

   実行結果：
   ```plaintext
   script.py:5: error: Argument 1 to "add" has incompatible type "str"; expected "int"
   ```

---

### mypyの設定

mypyの設定ファイルをプロジェクトに追加すると、カスタマイズが可能です。設定ファイルの名前は以下から選択できます：

- `mypy.ini`
- `setup.cfg`
- `pyproject.toml`

#### 設定例（mypy.ini）

```ini
[mypy]
python_version = 3.10
ignore_missing_imports = True
strict = True
check_untyped_defs = True
warn_unused_ignores = True
```

**オプションの説明**：
- `python_version`: 使用しているPythonのバージョン。
- `ignore_missing_imports`: 外部ライブラリのインポートエラーを無視。
- `strict`: 厳格モードを有効化（推奨設定を包括的に適用）。
- `check_untyped_defs`: 型指定されていない関数もチェック対象に含める。
- `warn_unused_ignores`: 不要な`# type: ignore`を警告。

#### pyproject.tomlの設定例

```toml
[tool.mypy]
python_version = "3.10"
ignore_missing_imports = true
strict = true
```

---

### よく使うオプション

1. **型の強制チェック**
   - 型指定されていない部分も強制的にチェック：
     ```bash
     mypy script.py --strict
     ```

2. **特定ディレクトリの除外**
   - 型チェック対象から一部を除外：
     ```bash
     mypy . --exclude tests/
     ```

3. **型エラーを無視**
   - 特定の行で型エラーを無視：
     ```python
     result = add("10", 20)  # type: ignore
     ```

---

### mypyでチェック可能な型ヒント

1. **基本的な型**
   ```python
   age: int = 25
   name: str = "Alice"
   ```

2. **Union型**
   - 複数の型を許容する場合：
     ```python
     from typing import Union
     value: Union[int, str] = "hello"
     ```

3. **Optional型**
   - Noneを許容する場合：
     ```python
     from typing import Optional
     value: Optional[int] = None
     ```

4. **コレクション型**
   - リスト、辞書、タプルなど：
     ```python
     from typing import List, Dict, Tuple
     numbers: List[int] = [1, 2, 3]
     ```

5. **Callable型**
   - 関数の型を指定：
     ```python
     from typing import Callable
     def apply(func: Callable[[int, int], int], x: int, y: int) -> int:
         return func(x, y)
     ```

6. **カスタムクラス**
   ```python
   class User:
       name: str
       age: int
   ```

7. **TypedDict**
   - 特定のキーと値の型を持つ辞書：
     ```python
     from typing import TypedDict
     class Person(TypedDict):
         name: str
         age: int
     ```

---

### mypyのメリットとデメリット

#### メリット
- **早期バグ検出**：実行前に型の不整合を発見。
- **可読性の向上**：型ヒントによりコードの意図が明確に。
- **IDEの補完サポート**：型情報に基づく補完が向上。

#### デメリット
- **初期コスト**：型ヒントを追加する手間がかかる。
- **ランタイムエラーには無効**：実行時の問題は解決しない。

---

### mypyの適用範囲

- **新規プロジェクト**：
  最初から型ヒントを導入することで、コードの一貫性を確保。
- **既存プロジェクト**：
  部分的に型ヒントを追加して段階的に導入。

---

### まとめ

mypyは、Pythonの型ヒントを活用してコードの安全性と品質を高める強力なツールです。特に中規模以上のプロジェクトでは、型ヒントの導入とmypyの使用がバグを未然に防ぐ効果を発揮します。部分的な導入も可能なため、まずは小規模な範囲で試してみるのがおすすめです。