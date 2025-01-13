import requests
from bs4 import BeautifulSoup
import csv
import time

# 基本URLとCSVファイル名のペアを定義
sources = [
    {
        "base_url": "https://www.fe-siken.com/s/keyword/",
        "output_file": "fe_keywords_full.csv"
    },
    {
        "base_url": "https://www.ap-siken.com/s/keyword/",
        "output_file": "ap_keywords_full.csv"
    }
]

# すべての対象ページ
kana_list = [
    "xa", "xi", "xu", "xe", "xo",  # あ行
    "ka", "ki", "ku", "ke", "ko",  # か行
    "sa", "si", "su", "se", "so",  # さ行
    "ta", "ti", "tu", "te", "to",  # た行
    "na", "ni", "nu", "ne", "no",  # な行
    "ha", "hi", "hu", "he", "ho",  # は行
    "ma", "mi", "mu", "me", "mo",  # ま行
    "ya", "yu", "yo",              # や行
    "ra", "ri", "ru", "re", "ro",  # ら行
    "wa",                          # わ行
]

# アルファベットページを追加
alphabet_list = [f"_{chr(c)}" for c in range(ord("a"), ord("z") + 1)]
kana_list.extend(alphabet_list)

# 数字その他ページを追加
kana_list.append("_other")

# 各ソースを処理
for source in sources:
    base_url = source["base_url"]
    output_file = source["output_file"]
    all_keywords = []

    print(f"Processing: {base_url}")
    for kana in kana_list:
        url = f"{base_url}{kana}.html"
        print(f"Fetching: {url}")
        response = requests.get(url)

        # HTTPレスポンスの確認
        if response.status_code != 200:
            print(f"Failed to fetch {url}: {response.status_code}")
            continue

        # BeautifulSoupで解析
        soup = BeautifulSoup(response.content, "html.parser")
        keyword_boxes = soup.find_all("div", class_="keywordBox")

        # ページ内のキーワードを解析
        for box in keyword_boxes:
            term_element = box.find("p", class_="big")  # キーワードの要素
            if term_element:  # キーワードが存在するか確認
                term = term_element.text.strip()
            else:
                term = "N/A"

            cite_element = box.find("span", class_="cite")  # 英字表記
            if cite_element:
                cite = cite_element.text.strip().replace("、", ":").replace("，", ":")
            else:
                cite = "N/A"

            description_element = box.find("div")  # 説明
            description = description_element.text.strip() if description_element else "N/A"

            category_element = box.find("p", class_="grayText")  # カテゴリ
            category = category_element.text.strip() if category_element else "N/A"

            all_keywords.append({
                "term": term,
                "cite": cite,
                "description": description,
                "category": category
            })

        # サーバー負荷を軽減するために1秒待機
        time.sleep(1)

    # 結果をCSVファイルに保存
    with open(output_file, "w", newline="", encoding="utf-8") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=["term", "cite", "description", "category"])
        writer.writeheader()
        writer.writerows(all_keywords)

    print(f"キーワードが '{output_file}' に保存されました。")
