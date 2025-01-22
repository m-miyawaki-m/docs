UUID（GUID）は標準的には 32文字の16進数文字列 で構成され、通常はハイフンで区切られて表示されます。そのため、以下のような形式になり、合計36文字となります。

UUID（GUID）の形式

xxxxxxxx-xxxx-Mxxx-Nxxx-xxxxxxxxxxxx

x は16進数の数字（0～9およびa～f）

M はUUIDのバージョン（例: 1、3、4、5）

N はバリアント情報（8、9、a、b のいずれか）



---

桁数の内訳

xxxxxxxx (8文字)

xxxx (4文字)

Mxxx (4文字)

Nxxx (4文字)

xxxxxxxxxxxx (12文字)


合計で:

文字数: 32文字（16進数部分のみ）

ハイフンを含む場合: 36文字



---

Pythonで確認するコード例

import uuid

# UUIDの生成
guid = uuid.uuid4()

# 長さを確認
print(f"GUID: {guid}")
print(f"文字数（ハイフン含む）: {len(str(guid))}")
print(f"文字数（ハイフン除く）: {len(guid.hex)}")

実行結果

例:

GUID: 123e4567-e89b-12d3-a456-426614174000
文字数（ハイフン含む）: 36
文字数（ハイフン除く）: 32


---

結論

ハイフンあり: 36文字

ハイフンなし: 32文字


用途に応じて必要な形式を選択してください。

