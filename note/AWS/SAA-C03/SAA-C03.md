# AWS Certified Solutions Architect - Associate (SAA-C03) 試験ガイド
## はじめに
AWS Certified Solutions Architect - Associate (SAA-C03) 試験は、ソリューション アーキテクトの役割を担う個人を対象としています。
この試験では、AWS Well-Architected フレームワークに基づいてソリューションを設計する受験者の能力を 検証します。
また、次のタスクについての受験者の能力も検証します。
- 現在のビジネス要件と将来予測されるニーズを満たすように AWS のサービスを組み込んだソリューションを設計する。
- 安全性、耐障害性、高パフォーマンス、コスト最適化を実現したアーキテクチャを設計する。
- 既存のソリューションをレビューし、改善点を判断する。
受験対象者について
受験対象者には、AWS のサービスを使用するクラウドソリューション設計の実務 経験が 1 年以上必要です。
試験に出題される可能性のあるテクノロジーと概念のリスト、試験対象の AWS サービスと機能のリスト、および試験対象外の AWS サービスと機能のリストに ついては、付録を参照してください。
試験内容
解答タイプ
試験には次の 2 種類の設問があります。
- 択一選択問題: 正しい選択肢が 1 つ、誤った選択肢 (不正解) が 3 つ提示 される。
- 複数選択問題: 5 つ以上の選択肢のうち、正解が 2 つ以上ある。
設問の記述に最もよく当てはまるもの、または正解となるものを 1 つ以上選択 します。不正解の選択肢は、知識や技術が不十分な受験者が選択してしまいそうな、 設問内容と一致するもっともらしい解答になっています。
未解答の設問は不正解とみなされます。推測による解答にペナルティはありません。 試験には、スコアに影響する設問が 50 問含まれています。

採点対象外の設問
試験には、スコアに影響しない採点対象外の設問が 15 問含まれています。
AWS では、こういった採点対象外の設問での成績情報を収集し、今後採点対象の設問として使用できるかどうかを評価します。
試験では、どの設問が採点対象外かは受験者に わからないようになっています。

試験の結果
AWS Certified Solutions Architect - Associate (SAA-C03) 試験は、合否判定方式です。
試験の採点は、認定業界のベストプラクティスおよびガイドラインに基づいた、AWS の専門家によって定められる最低基準に照らして行われます。
試験の結果は、100～1,000 の換算スコアとして示されます。
合格スコアは 720 です。
このスコアにより、試験全体の成績と合否がわかります。
複数の試験間で難易度が わずかに異なる可能性があるため、スコアを均等化するためにスケールスコアが使用 されます。
スコアレポートには、各セクションの成績を示す分類表が含まれる場合があります。
試験には補整スコアリングモデルが使用されるため、セクションごとに合否ラインは 設定されておらず、試験全体のスコアで合否が判定されます。
試験の各セクションには特定の重みが設定されているため、各セクションに割り当て られる設問数が異なる場合があります。
分類表には、受験者の得意な部分と弱点を示す全般的な情報が含まれます。
セクションごとのフィードバックを解釈する際は注意してください。

## 試験内容の概要
この試験ガイドには、セクションに設定された重み、コンテンツドメイン、タスク ステートメントについての説明が含まれています。本ガイドは、試験内容の包括的な リストを提供するものではありません。
ただし、各 タスクステートメントの追加情報を使って、試験の準備に役立てることができます。
本試験のコンテンツドメインと重み設定は以下のとおりです。
- 第 1 分野: セキュアなアーキテクチャの設計 (採点対象コンテンツの 30%)
- 第 2 分野: 弾力性に優れたアーキテクチャの設計 (採点対象コンテンツの 26%)
- 第 3 分野: ⾼パフォーマンスなアーキテクチャの設計 (採点対象コンテンツの 24%)
- 第 4 分野: コストを最適化したアーキテクチャの設計 (採点対象コンテンツの 20%)


## 第 1 分野: セキュアなアーキテクチャの設計
### タスクステートメント 1.1: AWS リソースへのセキュアなアクセスを設計する。
**対象知識:**
- 複数のアカウントにまたがるアクセス制御と管理
- AWS フェデレーテッドアクセスとアイデンティティサービス (AWS Identity and Access Management [IAM]、AWS IAM Identity Center [AWS Single Sign-On] など)
- AWS グローバルインフラストラクチャ (アベイラビリティーゾーン、 AWS リージョンなど)
- AWS セキュリティのベストプラクティス (最小権限の原則など)
- AWS 責任共有モデル
**対象スキル:**
- AWS セキュリティのベストプラクティスを IAM ユーザーとルートユーザーに適用する (多要素認証 (MFA) など)。
- IAM ユーザー、グループ、ロール、ポリシーを含む柔軟な認証モデルを設計する。
- ロールベースのアクセスコントロール戦略 (AWS Security Token Service [AWS STS]、ロールスイッチング、クロスアカウントアクセスなど) を設計 する。
- 複数の AWS アカウント (AWS Control Tower、サービスコントロール ポリシー [SCP] など) のセキュリティ戦略を設計する。
- AWS のサービスに対するリソースポリシーの適切な使用を判断する。
- IAM ロールを使用して Directory Service をフェデレートする場面を判断 する。

### タスクステートメント 1.2: セキュアなワークロードとアプリケーションを設計する。
**対象知識:**
- アプリケーション設定と認証情報のセキュリティ
- AWS サービスエンドポイント
- AWS でポート、プロトコル、ネットワークトラフィックを制御
- セキュアなアプリケーションアクセス
- セキュリティサービスの適切なユースケース (Amazon Cognito、Amazon GuardDuty、Amazon Macie など)
- AWS 外部の脅威ベクトル (DDoS、SQL インジェクションなど)
**対象スキル:**
- セキュリティコンポーネント (セキュリティグループ、ルートテーブル、 ネットワーク ACL、NAT ゲートウェイなど) を使用した VPC アーキテクチャの設計
- ネットワークセグメンテーション戦略の決定 (パブリックサブネットと プライベートサブネットの使用など)
- AWS のサービスとの統合によるアプリケーションの保護 (AWS Shield、AWS WAF、IAM Identity Center、AWS Secrets Manager など)
- AWS クラウドと外部ネットワーク接続の保護 (VPN、AWS Direct Connect など)

### タスクステートメント 1.3: 適切なデータセキュリティ管理を判断する。
**対象知識:**
- データアクセスとガバナンス
- データ復旧
- データ保持と分類
- 暗号化と適切なキー管理
**対象スキル:**
- コンプライアンス要件を満たすために AWS テクノロジーを調整する。
- データを暗号化する (AWS Key Management Service [AWS KMS] など)。
- データを保護する (AWS KMS キーのローテーションなど)。
- 保管中のデータを暗号化する (AWS Key Management Service [AWS KMS] など)。
- 転送中のデータを暗号化する (TLS を使用した AWS Certificate Manager [ACM] など)。
- 暗号化キーにアクセスポリシーを実装する。
- データバックアップとレプリケーションを実装する。
- データアクセス、ライフサイクル、保護に関するポリシーを実装する。
- 暗号化キーのローテーションと証明書を更新する。

## 第 2 分野: 弾力性に優れたアーキテクチャの設計
### タスクステートメント 2.1: スケーラブルで疎結合なアーキテクチャを設計する。
**対象知識:**
- API の作成と管理 (Amazon API Gateway、REST API など)
- AWS マネージドサービスの適切なユースケース (AWS Transfer Family、Amazon Simple Queue Service [Amazon SQS]、Secrets Manager など)
- キャッシュ戦略
- マイクロサービスの設計原則 (ステートレスワークロードとステートフル ワークロードの比較など)
- イベント駆動型アーキテクチャ
- 垂直スケーリングと水平スケーリング
- エッジアクセラレーター (コンテンツ配信ネットワーク [CDN] など) を適切に使用する方法
- アプリケーションをコンテナに移行する方法
- ロードバランシングの概念 (Application Load Balancer など)
- 多層アーキテクチャ
- キューイングとメッセージングの概念 (パブリッシュ/サブスクライブなど)
- サーバーレステクノロジーとパターン (AWS Fargate、AWS Lambda など)
- ストレージの種類とその特性 (オブジェクト、ファイル、ブロックなど)
- コンテナのオーケストレーション (Amazon Elastic Container Service [Amazon ECS]、Amazon Elastic Kubernetes Service [Amazon EKS] など)
- リードレプリカを使用するタイミング
- ワークフローオーケストレーション (AWS Step Functions など)
**対象スキル:**
- 要件に基づいてイベント駆動型、マイクロサービス、多層アーキテクチャを設計する。
- アーキテクチャ設計で使用されるコンポーネントのスケーリング戦略を決定する。
- 要件に基づいて、疎結合を実現するために必要な AWS のサービスを決定 する。
- コンテナを使用する場面を判断する。
- サーバーレステクノロジーとパターンを使用する場面を判断する。
- 要件に基づいて適切なコンピューティング、ストレージ、ネットワーク、 データベーステクノロジーを推奨する。
- ワークロードに特化した AWS のサービスを使用する。

### タスクステートメント 2.2: 高可用性、フォールトトレラントなアーキテクチャを設計する。
**対象知識:**
- AWS グローバルインフラストラクチャ (アベイラビリティーゾーン、AWS リージョン、Amazon Route 53 など)
- AWS マネージドサービスの適切なユースケース (Amazon Comprehend、Amazon Polly など)
- ネットワークの基本概念 (ルートテーブルなど)
- 災害対策 (DR) 戦略 (バックアップと復元、パイロットライト、ウォーム スタンバイ、アクティブ/アクティブフェイルオーバー、目標復旧時点 [RPO]、目標復旧時間 [RTO] など)
- 分散型設計パターン
- フェイルオーバー戦略
- イミュータブルインフラストラクチャ
- ロードバランシングの概念 (Application Load Balancer など)
- プロキシの概念 (Amazon RDS プロキシなど)
- Service Quotas とスロットリング (スタンバイ環境でワークロードの Service Quotas を構成する方法など)
- ストレージオプションと特性 (耐久性、レプリケーションなど)
- ワークロードの可視性 (AWS X-Ray など)
**対象スキル:**
- インフラストラクチャの整合性を確保するオートメーション戦略を決定 する。
- AWS リージョンまたはアベイラビリティーゾーン全体にわたって、可用性が高く耐障害性のあるアーキテクチャを提供するのに必要な AWS のサービスを決定する。
- ビジネス要件に基づいてメトリクスを特定し、可用性の高いソリューションを提供する。
- 単一障害点を軽減する設計を実装する。
- データの耐久性と可用性を確保するための戦略 (バックアップなど) を実装 する。
- ビジネス要件を満たす適切な DR 戦略を選択する。
- レガシーアプリケーションやクラウドに最適化されていない アプリケーション (アプリケーションの変更が不可能な場合など) の信頼性を向上させるために AWS サービスを利用する。
- ワークロードに特化した AWS のサービスを使用する。

## 第 3 分野: 高パフォーマンスなアーキテクチャの設計
### タスクステートメント 3.1: 高パフォーマンスでスケーラブルなストレージ ソリューションを選択する。
**対象知識:**
- ビジネス要件を満たすハイブリッドストレージソリューション
- ストレージサービスの適切なユースケース (Amazon S3、Amazon Elastic File System [Amazon EFS]、Amazon Elastic Block Store [Amazon EBS] など)
- ストレージの種類とその特性 (オブジェクト、ファイル、ブロックなど)
**対象スキル:**
- パフォーマンス要件を満たすストレージサービスと設定を決定する。
- 将来のニーズに合わせてスケールできるストレージサービスを特定する。

### タスクステートメント 3.2: 高パフォーマンスで伸縮性があるコンピューティング ソリューションを設計する。
**対象知識:**
- AWS コンピューティングサービスの適切なユースケース (AWS Batch、Amazon EMR、Fargate など)
- AWS グローバルインフラストラクチャとエッジサービスによって提供される分散コンピューティングの概念
- キューイングとメッセージングの概念 (パブリッシュ/サブスクライブなど)
- 適切なユースケースによるスケーラビリティ機能 (Amazon EC2 Auto Scaling、AWS Auto Scaling など)
- サーバーレステクノロジーとパターン (Lambda、Fargate など)
- コンテナのオーケストレーション (Amazon ECS、Amazon EKS など)
**対象スキル:**
- コンポーネントを個別にスケールできるようにワークロードを疎結合に する。
- スケーリングアクションを実行するメトリクスと条件を特定する。
- ビジネス要件を満たす適切なコンピューティングオプションと機能 (EC2 インスタンスタイプなど) を選択する
- ビジネス要件を満たす適切なリソースタイプとサイズ (Lambda メモリの容量など) を選択する。

### タスクステートメント 3.3: 高パフォーマンスなデータベースソリューションを選択 する。
**対象知識:**
- AWS グローバルインフラストラクチャ (アベイラビリティーゾーン、 AWS リージョンなど)
- キャッシュ戦略とサービス (Amazon ElastiCache など)
- データアクセスパターン (読み取り集中型と書き込み集中型など)
- データベースキャパシティープランニング (キャパシティーユニット、 インスタンスタイプ、プロビジョンド IOPS など)
- データベース接続とプロキシ
- データベースエンジンの適切なユースケース (異種間移行、同種間移行など)
- データベースレプリケーション (リードレプリカなど)
- データベースタイプとサービス (サーバーレス、リレーショナル、非リレーショナル、インメモリなど)
**対象スキル:**
- ビジネス要件を満たすようにリードレプリカを設定する。
- データベースアーキテクチャを設計する。
- 適切なデータベースエンジンを決定する (MySQL と PostgreSQL の比較 など)。
- 適切なデータベースタイプを決定する (Amazon Aurora、Amazon DynamoDB など)。
- ビジネス要件に合わせてキャッシングを統合する。

### タスクステートメント 3.4: 高パフォーマンスでスケーラブルなネットワーク アーキテクチャを選択する。
**対象知識:**
- エッジネットワークサービスの適切なユースケース (Amazon CloudFront、AWS Global Accelerator など)
- ネットワークアーキテクチャの設計方法 (サブネット層、ルーティング、 IP アドレス指定など)
- ロードバランシングの概念 (Application Load Balancer など)
- ネットワーク接続オプション (AWS VPN、Direct Connect、AWS PrivateLink など)
**対象スキル:**
- さまざまなアーキテクチャ (グローバル、ハイブリッド、多層など) の ネットワークトポロジを作成する。
- 将来のニーズに合わせてスケールできるネットワーク設定を決定する。
- ビジネス要件を満たす適切なリソース配置を決定する。
- 適切なロードバランシング戦略を選択する。

### タスクステートメント 3.5: 高パフォーマンスなデータ取り込みと変換の ソリューションを選択する。
**対象知識:**
- データ分析および視覚化サービスの適切なユースケース (Amazon Athena、AWS Lake Formation、Amazon QuickSight など)
- データ取り込みパターン (頻度など)
- データ転送サービスの適切なユースケース (AWS DataSync、AWS Storage Gateway など)
- データ変換サービスの適切なユースケース (AWS Glue など)
- 取り込みアクセスポイントへのセキュアなアクセス
- ビジネス要件に必要なサイズと速度
- ストリーミングデータサービスの適切なユースケース (Amazon Kinesis など)
**対象スキル:**
- データレイクを構築および保護する。
- データストリーミングアーキテクチャを設計する。
- データ転送ソリューションを設計する。
- 可視化戦略を実装する。
- データ処理に適したコンピューティングオプション (Amazon EMR など) を 選択する。
- 取り込みに適した設定を選択する。
- 形式間でデータを変換する (.csv から .parquet など)。

## 第 4 分野: コストを最適化したアーキテクチャの設計
### タスクステートメント 4.1: コストを最適化したストレージソリューションを設計 する。
**対象知識:**
- アクセスオプション (リクエスタ支払いのオブジェクトストレージを持つ S3 バケットなど)
- AWS コスト管理サービスの機能 (コスト配分タグ、マルチアカウント請求 など)
- AWS コスト管理ツールの適切なユースケース (AWS Cost Explorer、AWS Budgets、AWS Cost and Usage Report など)
- AWS ストレージサービスの適切なユースケース (Amazon FSx、Amazon EFS、Amazon S3、Amazon EBS など)
- バックアップ戦略
- ブロックストレージオプション (ハードディスクドライブ [HDD] ボリュームタイプ、ソリッドステートドライブ [SSD] ボリュームタイプなど)
- データライフサイクル
- ハイブリッドストレージオプション (DataSync、Transfer Family、 Storage Gateway など)
- ストレージアクセスパターン
- ストレージ階層化 (オブジェクトストレージのコールド階層化など)
- ストレージの種類とその特性 (オブジェクト、ファイル、ブロックなど)
**対象スキル:**
- 適切なストレージ戦略を設計する (Amazon S3 へのバッチアップロードと 個別のアップロードとの比較など)。
- ワークロードに適したストレージサイズを決定する。
- ワークロードのデータを AWS ストレージに転送する際に最もコストが低い方法を判断する。
- ストレージのオートスケーリングが必要な場面を判断する。
- S3 オブジェクトのライフサイクルを管理する。
- 適切なバックアップとアーカイブソリューションを選択する。
- ストレージサービスへのデータ移行に適したサービスを選択する。
- 適切なストレージ階層を選択する。
- ストレージに適切なデータライフサイクルを選択する。
- ワークロードに応じて最も費用対効果の高いストレージサービスを選択 する。

### タスクステートメント 4.2: コストを最適化したコンピューティングソリューションを設計する。
**対象知識:**
- AWS コスト管理サービスの機能 (コスト配分タグ、マルチアカウント請求 など)
- AWS コスト管理ツールの適切なユースケース (Cost Explorer、AWS Budgets、AWS Cost and Usage Report など)
- AWS グローバルインフラストラクチャ (アベイラビリティーゾーン、AWS リージョンなど)
- AWS 購入オプション (スポットインスタンス、リザーブドインスタンス、Savings Plans など)
- 分散コンピューティング戦略 (エッジ処理など)
- ハイブリッドコンピューティングオプション (AWS Outposts、AWS Snowball Edge など)
- インスタンスタイプ、ファミリー、サイズ (メモリ最適化、 コンピューティング最適化、仮想化など)
- コンピューティング使用率の最適化 (コンテナ、サーバーレス コンピューティング、マイクロサービスなど)
- スケーリング戦略 (オートスケーリング、休止状態など)
**対象スキル:**
- 適切なロードバランシング戦略を判断する (Application Load Balancer [レイヤー 7]、Network Load Balancer [レイヤー 4]、Gateway Load Balancer の比較など)。
- 伸縮性のあるワークロードのための適切なスケーリング方法と戦略を決定 する (水平と垂直の比較、EC2 の休止状態など)。
- 費用対効果の高い AWS コンピューティングサービスをユースケースに 応じて決定する (Lambda、Amazon EC2、Fargate など)。
- さまざまなクラスのワークロード (本番ワークロード、非本番ワークロードなど) に必要な可用性を判断する。
- ワークロードに適したインスタンスファミリーを選択する。
- ワークロードに適したインスタンスサイズを選択する

### タスクステートメント 4.3: コストを最適化したデータベースソリューションを設計 する。
**対象知識:**
- AWS コスト管理サービスの機能 (コスト配分タグ、マルチアカウント請求 など)
- AWS コスト管理ツールの適切なユースケース (Cost Explorer、AWS Budgets、AWS Cost and Usage Report など)
- キャッシュ戦略
- データ保持ポリシー
- データベースキャパシティープランニング (キャパシティーユニットなど)
- データベース接続とプロキシ
- データベースエンジンの適切なユースケース (異種間移行、同種間移行など)
- データベースレプリケーション (リードレプリカなど)
- データベースタイプとサービス (リレーショナルと非リレーショナル、Aurora、DynamoDB の比較など)
**対象スキル:**
- 適切なバックアップポリシーと保持ポリシー (スナップショットの頻度など) を設計する。
- 適切なデータベースエンジンを決定する (MySQL と PostgreSQL の比較 など)。
- 費用対効果の高い AWS データベースサービスをユースケースに応じて決定する (DynamoDB と Amazon RDS、サーバーレスとの比較など)。
- 費用対効果の高い AWS データベースタイプ (時系列形式、列指向形式など) を決定する。
- 異なるデータベーススキーマまたは、異なるデータベースエンジンに移行 する。

### タスクステートメント 4.4: コストを最適化したネットワークアーキテクチャを設計 する。
**対象知識:**
- AWS コスト管理サービスの機能 (コスト配分タグ、マルチアカウント請求 など)
- AWS コスト管理ツールの適切なユースケース (Cost Explorer、AWS Budgets、AWS Cost and Usage Report など)
- ロードバランシングの概念 (Application Load Balancer など)
- NAT ゲートウェイ (NAT インスタンスと NAT ゲートウェイのコスト比較 など)
- ネットワーク接続 (プライベート回線、専用回線、VPN など)
- ネットワークルーティング、トポロジ、ピアリング (AWS Transit Gateway、VPC ピアリングなど)
- ネットワークサービスの適切なユースケース (DNS など)
**対象スキル:**
- 適切な NAT ゲートウェイタイプ (1 つの共有 NAT ゲートウェイと各 アベイラビリティーゾーンの NAT ゲートウェイの比較など) を設定する。
- 適切なネットワーク接続を設定する (Direct Connect、VPN、インターネットの比較など)。
- ネットワーク転送コストを最小限に抑えるために適切なネットワークルートを設定する (リージョン間、アベイラビリティーゾーン間、プライベート からパブリック、Global Accelerator、VPC エンドポイントなど)。
- コンテンツ配信ネットワーク (CDN) とエッジキャッシュに対する戦略的 ニーズを判断する。
- 既存のワークロードをレビューしてネットワークを最適化する。
- 適切なスロットリング戦略を選択する。
- ネットワークデバイスに適切な帯域幅割り当てを選択する (単一の VPN と 複数の VPN の比較、Direct Connect の速度など)。

付録
試験に出題される可能性のあるテクノロジーと概念
以下は、試験に出題される可能性のあるテクノロジーと概念のリストです。この リストはすべてを網羅しているわけではなく、また、変更される場合があります。 このリストにおける項目の掲載順序や配置は、その項目の相対的な重みや試験に おける重要性を示すものではありません。
- コンピューティング
- コスト管理
- データベース
- 災害対策
- 高パフォーマンス
- マネジメントとガバナンス
- マイクロサービスとコンポーネントの配信
- 移行とデータ転送
- ネットワーク、接続、コンテンツ配信
- 回復性
- セキュリティ
- サーバーレスでイベント駆動型の設計原則
- ストレージ

範囲内の AWS のサービスと機能
以下に、試験範囲の AWS のサービスと機能のリストを示します。このリストは すべてを網羅しているわけではなく、また、変更される場合があります。各 AWS の サービスは、サービスの主な機能に応じたカテゴリに分けられています。
分析:
- Amazon Athena
- AWS Data Exchange
- AWS Data Pipeline
- Amazon EMR
- AWS Glue
- Amazon Kinesis
- AWS Lake Formation
- Amazon Managed Streaming for Apache Kafka (Amazon MSK)
- Amazon OpenSearch Service
- Amazon QuickSight
- Amazon Redshift
アプリケーション統合:
- Amazon AppFlow
- AWS AppSync
- Amazon EventBridge
- Amazon MQ
- Amazon Simple Notification Service (Amazon SNS)
- Amazon Simple Queue Service (Amazon SQS)
- AWS Step Functions
AWS コスト管理:
- AWS Budgets
- AWS Cost and Usage Report
- AWS Cost Explorer
- Savings Plans
コンピューティング:
- AWS Batch
- Amazon EC2
- Amazon EC2 Auto Scaling
- AWS Elastic Beanstalk
- AWS Outposts
- AWS Serverless Application Repository
- VMware Cloud on AWS
- AWS Wavelength
コンテナ:
- Amazon ECS Anywhere
- Amazon EKS Anywhere
- Amazon EKS Distro
- Amazon Elastic Container Registry (Amazon ECR)
- Amazon Elastic Container Service (Amazon ECS)
- Amazon Elastic Kubernetes Service (Amazon EKS)
データベース:
- Amazon Aurora
- Amazon Aurora Serverless
- Amazon DocumentDB (MongoDB 互換)
- Amazon DynamoDB
- Amazon ElastiCache
- Amazon Keyspaces (Apache Cassandra 向け)
- Amazon Neptune
- Amazon Quantum Ledger Database (Amazon QLDB)
- Amazon RDS
- Amazon Redshift
デベロッパーツール:
- AWS X-Ray
フロントエンドのウェブとモバイル:
- AWS Amplify
- Amazon API Gateway
- AWS Device Farm
- Amazon Pinpoint

機械学習:
- Amazon Comprehend
- Amazon Forecast
- Amazon Fraud Detector
- Amazon Kendra
- Amazon Lex
- Amazon Polly
- Amazon Rekognition
- Amazon SageMaker
- Amazon Textract
- Amazon Transcribe
- Amazon Translate

マネジメントとガバナンス:
- AWS Auto Scaling
- AWS CloudFormation
- AWS CloudTrail
- Amazon CloudWatch
- AWS コマンドラインインターフェイス (AWS CLI)
- AWS Compute Optimizer
- AWS Config
- AWS Control Tower
- AWS Health Dashboard
- AWS License Manager
- Amazon Managed Grafana
- Amazon Managed Service for Prometheus
- AWS マネジメントコンソール
- AWS Organizations
- AWS Proton
- AWS Service Catalog
- AWS Systems Manager
- AWS Trusted Advisor
- AWS Well-Architected Tool

メディアサービス:
- Amazon Elastic Transcoder
- Amazon Kinesis Video Streams

移行と転送:
- AWS Application Discovery Service
- AWS Application Migration Service
- AWS Database Migration Service (AWS DMS)
- AWS DataSync
- AWS Migration Hub
- AWS Snow ファミリー
- AWS Transfer Family

ネットワークとコンテンツ配信:
- AWS Client VPN
- Amazon CloudFront
- AWS Direct Connect
- Elastic Load Balancing (ELB)
- AWS Global Accelerator
- AWS PrivateLink
- Amazon Route 53
- AWS Site-to-Site VPN
- AWS Transit Gateway
- Amazon VPC

セキュリティ、アイデンティティ、コンプライアンス:
- AWS Artifact
- AWS Audit Manager
- AWS Certificate Manager (ACM)
- AWS CloudHSM
- Amazon Cognito
- Amazon Detective
- AWS Directory Service
- AWS Firewall Manager
- Amazon GuardDuty
- AWS IAM Identity Center (AWS Single Sign-On)
- AWS Identity and Access Management (IAM)
- Amazon Inspector
- AWS Key Management Service (AWS KMS)
- Amazon Macie
- AWS Network Firewall
- AWS Resource Access Manager (AWS RAM)
- AWS Secrets Manager
- AWS Security Hub
- AWS Shield
- AWS WAF

サーバーレス:
- AWS AppSync
- AWS Fargate
- AWS Lambda

ストレージ:
- AWS Backup
- Amazon Elastic Block Store (Amazon EBS)
- Amazon Elastic File System (Amazon EFS)
- Amazon FSx (すべてのタイプに対応)
- Amazon S3
- Amazon S3 Glacier
- AWS Storage Gateway

範囲外の AWS のサービスと機能
以下に、試験対象外の AWS のサービスと機能のリストを示します。
このリストは すべてを網羅しているわけではなく、また、変更される場合があります。試験の対象となる職務内容に完全に関係のない AWS のサービスは、このリストから除外されて います。

分析:
- Amazon CloudSearch
アプリケーション統合:
- Amazon Managed Workflows for Apache Airflow (Amazon MWAA)

AR およびバーチャルリアリティ:
- Amazon Sumerian

ブロックチェーン:
- Amazon Managed Blockchain

コンピューティング:
- Amazon Lightsail

データベース:
- Amazon RDS on VMware

デベロッパーツール:
- AWS Cloud9
- AWS Cloud Development Kit (AWS CDK)
- AWS CloudShell
- AWS CodeArtifact
- AWS CodeBuild
- AWS CodeCommit
- AWS CodeDeploy
- Amazon CodeGuru
- AWS CodeStar
- Amazon Corretto
- AWS Fault Injection Simulator (AWS FIS)
- AWS のツールと SDK

フロントエンドのウェブとモバイル:
- Amazon Location Service

ゲーム関連テクノロジー:
- Amazon GameLift
- Amazon Lumberyard

IoT:
- すべてのサービス

機械学習:
- Apache MXNet on AWS
- Amazon Augmented AI (Amazon A2I)
- AWS DeepComposer
- AWS Deep Learning AMIs (DLAMI)
- AWS Deep Learning Containers
- AWS DeepLens
- AWS DeepRacer
- Amazon DevOps Guru
- Amazon Elastic Inference
- Amazon HealthLake
- AWS Inferentia
- Amazon Lookout for Equipment
- Amazon Lookout for Metrics
- Amazon Lookout for Vision
- Amazon Monitron
- AWS Panorama
- Amazon Personalize
- PyTorch on AWS
- Amazon SageMaker Data Wrangler
- Amazon SageMaker Ground Truth
- TensorFlow on AWS

マネジメントとガバナンス:
- AWS Chatbot
- AWS コンソールモバイルアプリケーション
- AWS Distro for OpenTelemetry
- AWS OpsWorks

メディアサービス:
- AWS Elemental アプライアンスとソフトウェア
- AWS Elemental MediaConnect
- AWS Elemental MediaConvert
- AWS Elemental MediaLive
- AWS Elemental MediaPackage
- AWS Elemental MediaStore
- AWS Elemental MediaTailor
- Amazon Interactive Video Service (Amazon IVS)

移行と転送:
- Migration Evaluator

ネットワークとコンテンツ配信:
- AWS App Mesh
- AWS Cloud Map

量子テクノロジー:
- Amazon Braket

ロボティクス:
- AWS RoboMaker

人工衛星:
- AWS Ground Station