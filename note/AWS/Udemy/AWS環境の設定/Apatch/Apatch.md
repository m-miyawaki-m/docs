以下に、このスレッドのApacheの設定手順を整理して簡潔にまとめます。

---

## **Apacheのインストールと設定手順**

### **1. Apacheのインストール**
Amazon LinuxまたはUbuntuの場合:
```bash
# Amazon Linux
sudo yum install httpd -y

# Ubuntu
sudo apt install apache2 -y
```

### **2. 必要なモジュールの有効化**
Apacheのリバースプロキシ機能を有効にします。
```bash
# Amazon Linux
sudo yum install mod_proxy mod_proxy_http -y

# Ubuntu
sudo a2enmod proxy
sudo a2enmod proxy_http
```

### **3. Apacheの設定ファイルを編集**
Apacheの設定ファイル（`/etc/httpd/conf/httpd.conf` または `/etc/apache2/sites-available/000-default.conf`）に以下を追加。

#### 基本的なリバースプロキシ設定
```apache
<VirtualHost *:80>
    ServerAdmin webmaster@localhost

    ProxyRequests off
    ProxyPreserveHost On
    ProxyPass / http://localhost:8080/webapp10/
    ProxyPassReverse / http://localhost:8080/webapp10/

    <Proxy *>
        Require all granted
    </Proxy>

    LogLevel warn
    CustomLog /var/log/httpd/access_log combined
    ErrorLog /var/log/httpd/error_log
</VirtualHost>
```

### **4. Apacheの起動と自動起動設定**
```bash
# Apacheの起動
sudo systemctl start httpd  # Amazon Linux
sudo systemctl start apache2  # Ubuntu

# Apacheの自動起動設定
sudo systemctl enable httpd  # Amazon Linux
sudo systemctl enable apache2  # Ubuntu
```

---

### **5. セキュリティ強化（オプション）**
#### **特定IPのみにアクセスを許可**
`<Proxy>`セクションを以下のように変更します:
```apache
<Proxy *>
    Require ip 192.168.1.0/24  # ローカルネットワークからのみ許可
</Proxy>
```

---

### **6. HTTPSの設定（任意）**
1. **Let's Encryptをインストール**
   ```bash
   sudo yum install certbot python3-certbot-apache -y  # Amazon Linux
   sudo apt install certbot python3-certbot-apache -y  # Ubuntu
   ```

2. **証明書の取得**
   ```bash
   sudo certbot --apache -d your-domain.com
   ```

3. **HTTPSの設定**
   HTTPS用の`<VirtualHost>`セクションを追加:
   ```apache
   <VirtualHost *:443>
       ServerAdmin webmaster@localhost
       SSLEngine on
       SSLCertificateFile /etc/letsencrypt/live/your-domain.com/fullchain.pem
       SSLCertificateKeyFile /etc/letsencrypt/live/your-domain.com/privkey.pem

       ProxyRequests off
       ProxyPreserveHost On
       ProxyPass / http://localhost:8080/webapp10/
       ProxyPassReverse / http://localhost:8080/webapp10/

       <Proxy *>
           Require all granted
       </Proxy>
   </VirtualHost>
   ```

---

### **7. 設定の反映と確認**
1. **設定ファイルのテスト**
   ```bash
   sudo apachectl configtest
   ```

2. **Apacheの再起動**
   ```bash
   sudo systemctl restart httpd  # Amazon Linux
   sudo systemctl restart apache2  # Ubuntu
   ```

3. **ブラウザで確認**
   - `http://your-ec2-public-ip/`にアクセスしてTomcatのアプリケーションが表示されることを確認。

---

これで、Apacheの設定が完了し、Tomcatアプリケーション（`webapp10`）がリバースプロキシ経由で動作するようになります。必要に応じてセキュリティやHTTPSの設定を強化してください。