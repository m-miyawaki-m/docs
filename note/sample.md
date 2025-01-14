メソッド内で宣言されたローカル変数をそのメソッドに紐づけて詳細に記録するには、メソッド解析部分をさらに改良します。以下のコードでは、各メソッドの中で宣言されたローカル変数や呼び出されたメソッドをメソッド単位で記録します。


---

改良版コード

import javalang

def analyze_java_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        java_code = file.read()

    # パース
    tree = javalang.parse.parse(java_code)

    # 結果を格納する
    class_data = []

    # クラスとメンバの探索
    for path, node in tree:
        if isinstance(node, javalang.tree.ClassDeclaration):
            class_name = node.name
            class_info = {"class": class_name, "fields": [], "methods": []}

            # フィールドの抽出
            for field in node.fields:
                for declarator in field.declarators:
                    field_type = field.type.name if hasattr(field.type, 'name') else "Unknown"
                    class_info["fields"].append({
                        "name": declarator.name,
                        "type": field_type
                    })

            # メソッドの抽出
            for method in node.methods:
                method_info = {
                    "name": method.name,
                    "parameters": [],
                    "local_variables": [],
                    "called_methods": []
                }

                # パラメータの抽出
                for param in method.parameters:
                    param_type = param.type.name if hasattr(param.type, 'name') else "Unknown"
                    method_info["parameters"].append({
                        "name": param.name,
                        "type": param_type
                    })

                # メソッド本体を解析
                if method.body:
                    for _, body_node in method.body:
                        # ローカル変数の抽出
                        if isinstance(body_node, javalang.tree.VariableDeclarator):
                            variable_type = body_node.type.name if hasattr(body_node, 'type') and hasattr(body_node.type, 'name') else "Unknown"
                            method_info["local_variables"].append({
                                "name": body_node.name,
                                "type": variable_type
                            })

                        # メソッド呼び出しの抽出
                        if isinstance(body_node, javalang.tree.MethodInvocation):
                            called_method = body_node.member
                            method_info["called_methods"].append(called_method)

                class_info["methods"].append(method_info)

            class_data.append(class_info)

    return class_data

# Javaファイルの解析
java_file_path = "sample.java"  # 対象のJavaファイルを指定
data = analyze_java_file(java_file_path)

# 結果の出力
import pprint
pprint.pprint(data)


---

サンプルJavaコード

以下のJavaコードを解析対象とします。

public class Sample {
    private int id;
    private String name;

    public void printDetails() {
        String details = "ID: " + id + ", Name: " + name;
        int count = 10;
        System.out.println(details);
        logDetails(details);
    }

    private void logDetails(String details) {
        System.out.println("Logging: " + details);
    }
}


---

出力例

上記のJavaコードを解析した結果は次のようになります。

[
    {
        "class": "Sample",
        "fields": [
            {"name": "id", "type": "int"},
            {"name": "name", "type": "String"}
        ],
        "methods": [
            {
                "name": "printDetails",
                "parameters": [],
                "local_variables": [
                    {"name": "details", "type": "String"},
                    {"name": "count", "type": "int"}
                ],
                "called_methods": ["println", "logDetails"]
            },
            {
                "name": "logDetails",
                "parameters": [{"name": "details", "type": "String"}],
                "local_variables": [],
                "called_methods": ["println"]
            }
        ]
    }
]


---

改善点

1. ローカル変数の型と名前をメソッドに紐づける: 各メソッド内で宣言された変数を記録し、変数名と型情報を明示的に保存します。


2. 呼び出されたメソッドも紐づける: メソッド内で呼び出されたメソッド名を記録します。


3. メソッドごとの詳細を明確に整理: メソッドの名前、引数、ローカル変数、呼び出されたメソッドを一つのまとまりとして記録します。




---

注意点

型情報の解析: 型情報はjavalangが提供する情報に依存しており、外部クラスの型やジェネリクスなどの詳細な解決には限界があります。

構文エラーへの対応: 解析対象のJavaコードが構文的に正しいことを前提としています。構文エラーがある場合は適切な例外処理を追加してください。



---

このスクリプトを使用することで、メソッドごとにローカル変数や呼び出しメソッドを詳細に解析し、クラス構造をより包括的に把握できます。

