import pandas as pd
from IPython.core.display import display, HTML
from tkinter import Tk, filedialog

# ファイル選択ダイアログを表示
Tk().withdraw()  # Tkinterのウィンドウを非表示
file_path = filedialog.askopenfilename(filetypes=[("CSV files", "*.csv")])

# CSVを読み込む
if file_path:
    df = pd.read_csv(file_path, encoding="utf-8", header=None)
    df.columns = ["Chapter", "Category", "Question", "Answer"]  # カラム名を設定

    # DataFrame を HTML に変換して表示
    html_table = df.to_html(index=False, escape=False)

    # HTMLをJupyter Notebook上で表示
    display(HTML(f"""
    <style>
        table {{ border-collapse: collapse; width: 100%; }}
        th, td {{ border: 1px solid black; padding: 8px; text-align: left; }}
        th {{ background-color: #f2f2f2; }}
    </style>
    <h2>CSV Data</h2>
    {html_table}
    """))
else:
    print("ファイルが選択されませんでした。")
