PythonでXMLを操作する際に使用される代表的なライブラリとその基本的な利用方法を以下にまとめます。

---

## 主なライブラリ
1. **xml.etree.ElementTree**: 標準ライブラリ。軽量でシンプル。
2. **lxml**: 高機能で高速。XPathやXSLTをサポート。
3. **xml.dom.minidom**: DOMベースでXMLを扱う。
4. **xml.sax**: SAXパーサを使用してイベントベースでXMLを処理する。

ここでは、標準ライブラリである`xml.etree.ElementTree`を中心に解説します。

---

## `xml.etree.ElementTree` の基本的な利用方法

### XMLの読み込みと解析

#### XMLファイルを解析する

```python
import xml.etree.ElementTree as ET

# XMLファイルを読み込む
tree = ET.parse('sample.xml')
root = tree.getroot()

# ルート要素のタグ名を取得
print(root.tag)

# 子要素をループで表示
for child in root:
    print(child.tag, child.attrib)
```

#### 文字列から解析する

```python
xml_data = """
<root>
    <child key="value">Text</child>
</root>
"""

root = ET.fromstring(xml_data)

print(root.tag)  # root
for child in root:
    print(child.tag, child.text)  # child Text
```

---

### XMLの生成

#### 新規XMLデータを作成する

```python
import xml.etree.ElementTree as ET

# ルート要素の作成
root = ET.Element('root')

# 子要素の追加
child = ET.SubElement(root, 'child')
child.set('key', 'value')  # 属性を追加
child.text = 'Text'        # テキストを追加

# XML文字列に変換
xml_string = ET.tostring(root, encoding='unicode')
print(xml_string)
```

#### ファイルに保存する

```python
tree = ET.ElementTree(root)
tree.write('output.xml', encoding='utf-8', xml_declaration=True)
```

---

### XMLの検索

#### 要素を検索する

```python
import xml.etree.ElementTree as ET

xml_data = """
<root>
    <child key="value">Text1</child>
    <child key="value2">Text2</child>
</root>
"""
root = ET.fromstring(xml_data)

# タグ名で検索
for child in root.findall('child'):
    print(child.attrib, child.text)

# 属性で検索
specific_child = root.find(".//child[@key='value2']")
print(specific_child.text)  # Text2
```

---

### よく使うメソッド

| メソッド                  | 説明                                           |
|---------------------------|------------------------------------------------|
| `ElementTree.parse(file)` | XMLファイルを解析してツリーを作成               |
| `ElementTree.fromstring(text)` | 文字列からXMLを解析してルート要素を取得       |
| `find(tag)`               | 特定のタグを持つ最初の要素を取得               |
| `findall(tag)`            | 特定のタグを持つすべての要素をリストで取得     |
| `set(key, value)`         | 要素に属性を設定                               |
| `get(key)`                | 属性値を取得                                   |
| `tostring(element)`       | 要素を文字列に変換                             |

---

## 注意点
- **名前空間付きXML**を扱う場合、名前空間のマッピングが必要です。
- 大規模XMLデータにはメモリ効率の良い`iterparse`を使用するとよいでしょう。

---

## その他のライブラリ

- **lxml**  
  高速で、XPathやXSLTを使いたい場合に最適です。以下のようにインストールして使用します。

  ```bash
  pip install lxml
  ```

  ```python
  from lxml import etree

  root = etree.XML('<root><child key="value">Text</child></root>')
  print(root.xpath('//child[@key="value"]/text()'))  # ['Text']
  ```

---

以上がPythonでXMLを扱う基本的な方法です。利用するXMLの構造や要件に応じて適切なライブラリを選択してください！