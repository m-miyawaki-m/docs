## **HRスキーマの調査に利用するSQLコマンド一覧**

**HRスキーマ（Human Resources）のテーブルやデータを確認するための基本的なコマンドを整理** しました。

---

### **1. HRスキーマの全テーブル一覧**
```sql
SELECT TABLE_NAME FROM USER_TABLES;
```
**または、DBA権限で実行する場合**
```sql
SELECT TABLE_NAME FROM DBA_TABLES WHERE OWNER = 'HR';
```

---

### **2. HRスキーマの全オブジェクト（テーブル、ビュー、シーケンス、インデックスなど）**
```sql
SELECT OBJECT_NAME, OBJECT_TYPE FROM USER_OBJECTS ORDER BY OBJECT_TYPE;
```
**DBA権限で調査**
```sql
SELECT OBJECT_NAME, OBJECT_TYPE FROM DBA_OBJECTS WHERE OWNER = 'HR' ORDER BY OBJECT_TYPE;
```

---

### **3. 各テーブルのカラム情報を取得**
#### **HRスキーマのすべてのテーブルのカラム情報**
```sql
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, DATA_LENGTH
FROM USER_TAB_COLUMNS
ORDER BY TABLE_NAME, COLUMN_ID;
```
**特定のテーブルのカラム情報**
```sql
SELECT COLUMN_NAME, DATA_TYPE, DATA_LENGTH
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEES';
```

---

### **4. HRスキーマのテーブルのレコード数を確認**
```sql
SELECT TABLE_NAME, NUM_ROWS
FROM USER_TABLES;
```
（NUM_ROWS は `ANALYZE TABLE` 実行後に更新される）

**最新のレコード数を取得する場合**
```sql
SELECT COUNT(*) FROM HR.EMPLOYEES;
SELECT COUNT(*) FROM HR.DEPARTMENTS;
SELECT COUNT(*) FROM HR.JOBS;
SELECT COUNT(*) FROM HR.LOCATIONS;
SELECT COUNT(*) FROM HR.COUNTRIES;
```

---

### **5. 各テーブルのデータ確認**
#### **EMPLOYEES テーブル**
```sql
SELECT * FROM HR.EMPLOYEES FETCH FIRST 10 ROWS ONLY;
```
または
```sql
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID, SALARY FROM HR.EMPLOYEES;
```

#### **DEPARTMENTS テーブル**
```sql
SELECT * FROM HR.DEPARTMENTS FETCH FIRST 10 ROWS ONLY;
```

#### **JOBS テーブル**
```sql
SELECT * FROM HR.JOBS;
```

#### **LOCATIONS テーブル**
```sql
SELECT * FROM HR.LOCATIONS;
```

#### **COUNTRIES テーブル**
```sql
SELECT * FROM HR.COUNTRIES;
```

---

### **6. HRスキーマの外部キー制約を確認**
```sql
SELECT CONSTRAINT_NAME, TABLE_NAME, R_CONSTRAINT_NAME
FROM USER_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'R';
```
**DBA権限でHRスキーマの制約を確認**
```sql
SELECT CONSTRAINT_NAME, TABLE_NAME, R_CONSTRAINT_NAME
FROM DBA_CONSTRAINTS
WHERE OWNER = 'HR' AND CONSTRAINT_TYPE = 'R';
```

---

### **7. HRスキーマのインデックス情報**
```sql
SELECT INDEX_NAME, TABLE_NAME, UNIQUENESS
FROM USER_INDEXES;
```
**特定のテーブルのインデックス**
```sql
SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEES';
```

---

### **8. HRスキーマのシノニム（Synonyms）を確認**
```sql
SELECT SYNONYM_NAME, TABLE_NAME
FROM USER_SYNONYMS;
```

---

### **9. HRスキーマのシーケンスを確認**
```sql
SELECT SEQUENCE_NAME FROM USER_SEQUENCES;
```
（HRスキーマにはデフォルトではシーケンスはないが、カスタマイズされている場合に確認）

---

### **10. HRスキーマのビューを確認**
```sql
SELECT VIEW_NAME FROM USER_VIEWS;
```
**EMP_DETAILS_VIEWの定義を表示**
```sql
SELECT TEXT FROM USER_VIEWS WHERE VIEW_NAME = 'EMP_DETAILS_VIEW';
```

---

### **11. HRスキーマの権限を確認**
**ユーザーHRに付与されている権限**
```sql
SELECT * FROM USER_SYS_PRIVS;
```

**HRが所有するオブジェクトに付与された権限**
```sql
SELECT * FROM USER_TAB_PRIVS;
```

---

## **まとめ**
HRスキーマを調査するために、以下の手順でデータを確認できます。

1. **テーブル一覧を取得** → `USER_TABLES`
2. **オブジェクト一覧を取得** → `USER_OBJECTS`
3. **各テーブルのカラム情報を取得** → `USER_TAB_COLUMNS`
4. **テーブルのレコード数を取得** → `COUNT(*)`
5. **データを確認** → `SELECT * FROM HR.<テーブル名>`
6. **外部キーやインデックスを確認** → `USER_CONSTRAINTS`, `USER_INDEXES`
7. **HRに付与されている権限を確認** → `USER_SYS_PRIVS`

---

これらのコマンドを実行すれば、HRスキーマの構造とデータを詳細に調査できます。