以下は、このスレッドの手順を整理し、わかりやすくまとめたものです。

---

## **目次**
1. [システムの更新とMySQLリポジトリの追加](#1-システムの更新とmysqlリポジトリの追加)
2. [MySQLのインストール](#2-mysqlのインストール)
3. [MySQLのサービス起動と初期セットアップ](#3-mysqlのサービス起動と初期セットアップ)
4. [MySQLユーザーとデータベースの作成](#4-mysqlユーザーとデータベースの作成)
5. [MySQLパスワードポリシーの設定変更](#5-mysqlパスワードポリシーの設定変更)
6. [テーブルの作成とデータ挿入](#6-テーブルの作成とデータ挿入)
7. [AWSセキュリティグループの設定](#7-awsセキュリティグループの設定)

---

### **1. システムの更新とMySQLリポジトリの追加**

1. **システムのパッケージを更新**:
   ```bash
   sudo yum update -y
   ```

2. **MySQLリポジトリを追加**:
   Amazon Linux 2の場合、以下を実行します。
   ```bash
   sudo yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
   ```

3. **リポジトリが正常に追加されたことを確認**:
   ```bash
   sudo yum repolist all | grep mysql
   ```

---

### **2. MySQLのインストール**

1. **MySQLサーバーパッケージをインストール**:
   ```bash
   sudo yum install -y mysql-community-server
   ```

2. **インストール後の確認**:
   ```bash
   mysql --version
   ```

---

### **3. MySQLのサービス起動と初期セットアップ**

1. **MySQLサービスを起動**:
   ```bash
   sudo systemctl start mysqld
   ```

2. **自動起動を有効化**:
   ```bash
   sudo systemctl enable mysqld
   ```

3. **初期パスワードの確認**:
   MySQLの初期パスワードをログから取得します。
   ```bash
   sudo grep 'temporary password' /var/log/mysqld.log
   ```

4. **セキュリティ設定を実行**:
   初期パスワードを使用してセキュリティ設定を行います。
   ```bash
   sudo mysql_secure_installation
   ```
   - パスワードを変更。
   - ユーザーの削除やリモートアクセス制限を設定。

---

### **4. MySQLユーザーとデータベースの作成**

1. **MySQLにログイン**:
   ```bash
   mysql -u root -p
   ```

2. **新しいデータベースを作成**:
   ```sql
   CREATE DATABASE my_database;
   ```

3. **新しいユーザーを作成**:
   ```sql
   CREATE USER 'test_user'@'localhost' IDENTIFIED BY 'secure_password123';
   ```

4. **権限を付与**:
   ```sql
   GRANT ALL PRIVILEGES ON my_database.* TO 'test_user'@'localhost';
   FLUSH PRIVILEGES;
   ```

5. **確認**:
   ```sql
   SHOW GRANTS FOR 'test_user'@'localhost';
   ```

---

### **5. MySQLパスワードポリシーの設定変更**

1. **パスワードポリシーを緩和**:
   ```sql
   SET GLOBAL validate_password.length = 4;
   SET GLOBAL validate_password.policy = LOW;
   ```

2. **`my.cnf`ファイルで設定を永続化**:
   ```bash
   sudo nano /etc/my.cnf
   ```
   以下を追加:
   ```ini
   [mysqld]
   validate_password.length=4
   validate_password.policy=LOW
   ```

3. **MySQLを再起動**:
   ```bash
   sudo systemctl restart mysqld
   ```

---

### **6. テーブルの作成とデータ挿入**

1. **テーブルの作成**:
   ```sql
   CREATE TABLE shain (
       id INT PRIMARY KEY,
       name VARCHAR(20) NOT NULL,
       sei CHAR(1) NOT NULL,
       nen INT NOT NULL,
       address VARCHAR(50) NOT NULL
   );
   ```

2. **データの挿入**:
   ```sql
   INSERT INTO shain (id, name, sei, nen, address) VALUES
   (100, '山田太郎', '男', 2002, '東京都世田谷区'),
   (101, '鈴木義信', '男', 2003, '宮城県仙台市'),
   (102, '佐藤香織', '女', 2004, '福岡県福岡市');
   ```

---

### **7. AWSセキュリティグループの設定**

1. **AWSコンソールでセキュリティグループを編集**:
   - **Inboundルール**に以下を追加:
     - **タイプ**: MySQL/Aurora
     - **ポート範囲**: 3306
     - **ソース**: 自分のIPアドレスまたは許可したい範囲。

2. **セキュリティグループの確認**:
   必要に応じて、インスタンスに適用されているセキュリティグループを確認し、適切な設定を行います。

---

### **まとめ**

この手順により、Amazon Linux 2環境でMySQLのインストール、設定、ユーザー・データベースの作成、AWSセキュリティグループの設定まで一通りの構築が完了します。必要に応じて各設定を調整してください！