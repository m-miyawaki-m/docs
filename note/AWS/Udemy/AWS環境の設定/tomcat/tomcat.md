以下は、このスレッドで行ったTomcatの設定手順を目次付きでまとめた内容です。

---

## **Tomcatの設定手順**

### **目次**
1. [ユーザーの作成と権限の設定](#1-ユーザーの作成と権限の設定)
2. [Tomcatのダウンロードと配置](#2-tomcatのダウンロードと配置)
3. [Tomcat専用ユーザーの作成](#3-tomcat専用ユーザーの作成)
4. [Tomcatサービスファイルの作成](#4-tomcatサービスファイルの作成)
5. [Tomcatサービスの有効化と起動](#5-tomcatサービスの有効化と起動)
6. [動作確認と追加設定](#6-動作確認と追加設定)

---

### **1. ユーザーの作成と権限の設定**

- **目的**: EC2インスタンスでTomcatを実行する専用ユーザーを作成し、適切な権限を設定する。
- **手順**:
  1. `tomcat`ユーザーを作成。
     ```bash
     sudo useradd -s /sbin/nologin tomcat
     ```
  2. Tomcatディレクトリに権限を付与。
     ```bash
     sudo chown -R tomcat:tomcat /opt/apache-tomcat
     sudo chmod -R 750 /opt/apache-tomcat
     ```

---

### **2. Tomcatのダウンロードと配置**

- **目的**: 必要なTomcatバージョンを公式サイトからダウンロードし、設定する。
- **手順**:
  1. 必要なTomcatをダウンロード。
     ```bash
     wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.97/bin/apache-tomcat-9.0.97.tar.gz
     ```
  2. 解凍して適切なディレクトリに配置。
     ```bash
     tar -xvzf apache-tomcat-9.0.97.tar.gz -C /opt
     mv /opt/apache-tomcat-9.0.97 /opt/apache-tomcat
     ```

---

### **3. Tomcat専用ユーザーの作成**

- **目的**: Tomcatをセキュアに実行するため、専用の`tomcat`ユーザーを作成。
- **手順**:
  1. `tomcat`ユーザーがシェルにログインしないよう設定。
     ```bash
     sudo useradd -s /sbin/nologin tomcat
     ```
  2. 所有権と権限を付与。
     ```bash
     sudo chown -R tomcat:tomcat /opt/apache-tomcat
     sudo chmod -R 750 /opt/apache-tomcat
     ```

---

### **4. Tomcatサービスファイルの作成**

- **目的**: Tomcatを`systemd`サービスとして登録し、簡単に管理できるようにする。
- **手順**:
  1. サービスファイルを作成。
     ```bash
     sudo vi /etc/systemd/system/tomcat.service
     ```
  2. 以下の内容を記述。
     ```ini
     [Unit]
     Description=Apache Tomcat Web Application Container
     After=network.target

     [Service]
     Type=forking
     User=tomcat
     Group=tomcat
     Environment=JAVA_HOME=/usr/lib/jvm/java-11-openjdk
     Environment=CATALINA_HOME=/opt/apache-tomcat
     Environment=CATALINA_BASE=/opt/apache-tomcat
     ExecStart=/opt/apache-tomcat/bin/startup.sh
     ExecStop=/opt/apache-tomcat/bin/shutdown.sh
     Restart=on-failure

     [Install]
     WantedBy=multi-user.target
     ```

---

### **5. Tomcatサービスの有効化と起動**

- **目的**: Tomcatをサービスとして起動し、システム起動時に自動起動するよう設定する。
- **手順**:
  1. サービスをリロード。
     ```bash
     sudo systemctl daemon-reload
     ```
  2. サービスを開始。
     ```bash
     sudo systemctl start tomcat
     ```
  3. サービスの自動起動を有効化。
     ```bash
     sudo systemctl enable tomcat
     ```

---

### **6. 動作確認と追加設定**

- **目的**: Tomcatが正しく動作しているか確認し、必要なポートを開放する。
- **手順**:
  1. サービスの状態確認。
     ```bash
     sudo systemctl status tomcat
     ```
  2. ブラウザでアクセス。
     - URL: `http://<EC2のパブリックIP>:8080`
  3. ポート開放（AWSセキュリティグループ設定）。
     - ポート8080を開放。

---

### **まとめ**

この手順を通して、EC2環境上でTomcatをセキュアかつ効率的に運用するための設定が完了しました。不明点があればお気軽にお問い合わせください！