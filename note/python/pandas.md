以下に「Pandas文法」の独立した項目を作成し、リストに従って文法例を分類・まとめました。

# Pandas 文法まとめ

---

## 1. **基礎操作**
Pandasを使ったデータの基本操作を以下に示します。

| No. | 問題 | コード例 |
|----|------|----------|
| 1 | データの最初の5行を表示 | `df.head()` |
| 2 | データの最後の5行を表示 | `df.tail()` |
| 3 | DataFrameサイズを確認 | `df.shape` |
| 4 | CSVファイルを読み込み、最初の5行を表示 | `df2 = pd.read_csv('input/data1.csv'); df2.head()` |
| 5 | 列で昇順に並び替え | `df.sort_values(by='fare')` |
| 6 | DataFrameをコピー | `df_copy = df.copy(); df_copy.head()` |
| 7 | 列のデータ型を確認 | `df.dtypes` |
| 8 | 列の型を変換 | `df['pclass'] = df['pclass'].astype(str)` |
| 9 | レコード数を確認 | `len(df)` |
| 10 | データ概要を確認 | `df.info()` |

---

## 2. **データ抽出**
DataFrameから特定の列や条件に基づくデータ抽出。

| No. | 問題 | コード例 |
|----|------|----------|
| 14 | 特定列の抽出 | `df['name']` |
| 15 | 複数列の抽出 | `df[['name', 'sex']]` |
| 16 | 行番号で抽出 | `df.iloc[:4]` |
| 17 | 行範囲を指定して抽出 | `df.iloc[4:10]` |
| 19 | locで特定列を抽出 | `df.loc[:, 'fare']` |
| 24 | 特定列を抽出しCSV出力 | `df2[['name', 'age', 'sex']].to_csv('output/file.csv')` |

---

## 3. **データ加工**
DataFrameのデータを変更・追加・削除する操作。

| No. | 問題 | コード例 |
|----|------|----------|
| 34 | 値の置換 | `df['sex'] = df['sex'].replace({'male': 0, 'female': 1})` |
| 38 | 新規列の追加 | `df['test'] = 1` |
| 41 | 列を削除 | `df.drop('body', axis=1, inplace=True)` |
| 47 | 欠損値の補完 | `df['age'].fillna(30, inplace=True)` |

---

## 4. **データマージ・連結**
複数のDataFrameを結合・連結する操作。

| No. | 問題 | コード例 |
|----|------|----------|
| 59 | 左結合 | `df2 = df2.merge(df3, how='left')` |
| 63 | 列方向に連結 | `df2 = pd.concat([df2, df4], axis=1)` |

---

## 5. **統計処理**
統計情報の計算や標準化、スケーリング。

| No. | 問題 | コード例 |
|----|------|----------|
| 66 | 平均値 | `df['age'].mean()` |
| 71 | グルーピング | `df.groupby('class').agg(['max', 'min', 'mean'])` |
| 74 | 標準化 | `from sklearn.preprocessing import StandardScaler; scaler = StandardScaler(); scaled = scaler.fit_transform(df[['English', 'Mathmatics', 'History']])` |

---

## 6. **可視化**
Pandasを使ったデータの可視化。

| No. | 問題 | コード例 |
|----|------|----------|
| 82 | 全数値列のヒストグラム | `df.hist()` |
| 88 | 散布図の作成 | `df.plot.scatter(x='age', y='fare')` |
| 89 | グラフタイトルの追加 | `plt.title('age-fare scatter')` |

---

## 7. **タイタニック号の生存者予測**
機械学習を用いた生存者予測の準備・実行。

| No. | 問題 | コード例 |
|----|------|----------|
| 94 | 特徴量とターゲットの分割 | `X = df_copy[['pclass', 'age', 'sex', 'fare', 'embarked']].values; y = df_copy['survived'].values` |
| 96 | ランダムフォレストで学習 | `from sklearn.ensemble import RandomForestClassifier; model = RandomForestClassifier(); model.fit(X_train, y_train)` |
| 98 | 精度評価 | `from sklearn.metrics import accuracy_score; accuracy_score(y_test, y_pred)` |

---

必要に応じて追加や具体例を教えてください！