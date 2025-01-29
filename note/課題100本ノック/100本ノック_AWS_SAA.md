AWS SAA（AWS Certified Solutions Architect - Associate）取得のための100本ノック


---

1. AWSの基本概念（基礎）

1. AWSの責任共有モデルを説明できるようにする。


2. AWSのリージョン、アベイラビリティゾーン（AZ）、エッジロケーションの違いを理解する。


3. AWSの料金体系（オンデマンド、リザーブド、スポットインスタンス）を比較する。


4. AWS Well-Architected Frameworkの5つの柱を理解する。


5. IAM（Identity and Access Management）の基本概念を理解し、IAMポリシーを適切に設定する。


6. AWS Organizationsを使って複数アカウントを管理する方法を学ぶ。


7. AWS CloudFormationを使用してインフラをコード化（IaC）する。


8. AWS CloudTrailを利用してAPIコールの監査を行う。


9. AWS Configを活用してリソースの変更をトラッキングする。


10. AWS Trusted Advisorの活用方法を学ぶ。




---

2. コンピューティングサービス（EC2, Lambda, Auto Scaling）

11. EC2インスタンスの種類（汎用、コンピューティング最適化、メモリ最適化など）を比較する。


12. EC2のセキュリティグループとネットワークACLの違いを説明する。


13. EC2インスタンスをAuto Scaling Group（ASG）でスケーリングする方法を学ぶ。


14. ELB（Elastic Load Balancer）の種類（ALB, NLB, CLB）を比較し、それぞれのユースケースを理解する。


15. EC2スポットインスタンスとリザーブドインスタンスの違いを説明する。


16. EBS（Elastic Block Store）のボリュームタイプ（gp3, io2, st1, sc1）を理解する。


17. EBSスナップショットを使ってバックアップを取得し、別のインスタンスに復元する。


18. EC2インスタンスのElastic IPを取得し、固定IPとして使用する。


19. Lambda関数を作成し、CloudWatch Logsでログを確認する。


20. Lambda関数の実行時間とメモリ設定を最適化する。




---

3. ストレージサービス（S3, EFS, EBS, Glacier）

21. S3のストレージクラス（Standard, IA, One Zone-IA, Glacier, Glacier Deep Archive）を比較する。


22. S3のバケットポリシーとACLの違いを説明する。


23. S3 Transfer Accelerationを使ってデータ転送を高速化する。


24. S3のバージョニング機能を有効化し、データの復元を行う。


25. S3のライフサイクルルールを設定し、データの自動アーカイブを実装する。


26. S3のクロスリージョンレプリケーション（CRR）を設定する。


27. S3イベント通知をLambdaと統合して処理を自動化する。


28. AWS Snowballを利用して大容量データを移行する。


29. EFS（Elastic File System）をEC2にマウントし、ファイルストレージを提供する。


30. Amazon Glacierを活用して長期データ保存を行う。




---

4. データベース（RDS, DynamoDB, Aurora, Redshift）

31. RDSのマルチAZ配置とリードレプリカの違いを理解する。


32. RDSのスナップショットを作成し、新しいインスタンスに復元する。


33. RDS Proxyを利用してデータベース接続を最適化する。


34. Auroraの特徴とRDS MySQLとの違いを説明する。


35. DynamoDBのパーティションキーとソートキーの概念を理解する。


36. DynamoDBのオンデマンドキャパシティとプロビジョンドキャパシティの違いを学ぶ。


37. DynamoDBのグローバルテーブルを設定し、マルチリージョンでデータを同期する。


38. DynamoDB Streamsを利用してリアルタイムデータ処理を行う。


39. Redshiftを利用してデータウェアハウスを構築する。


40. ElastiCache（Redis, Memcached）を活用してデータベースの負荷を軽減する。




---

5. ネットワーク（VPC, Route 53, Direct Connect）

41. VPCを作成し、パブリックサブネットとプライベートサブネットを設定する。


42. VPCピアリングを設定し、異なるVPC間で通信を可能にする。


43. AWS Direct Connectを利用してオンプレミス環境とAWSを接続する。


44. AWS Transit Gatewayを使って複数のVPCを統合する。


45. NATゲートウェイとインターネットゲートウェイの違いを説明する。


46. Route 53でカスタムドメインを設定し、DNSレコードを管理する。


47. Route 53のヘルスチェックを設定し、障害時のフェイルオーバーを実装する。


48. AWS WAFを利用してDDoS攻撃を防御する。


49. AWS Shieldを有効化し、追加のセキュリティ対策を講じる。


50. AWS VPNを設定し、AWSとオンプレミスを接続する。




---

6. 分析と監視（CloudWatch, CloudTrail, X-Ray）

51. CloudWatchメトリクスを活用してリソースのパフォーマンスを監視する。


52. CloudTrailを利用してAPIコールの履歴を確認する。


53. AWS X-Rayを使ってアプリケーションのパフォーマンスボトルネックを特定する。


54. CloudWatch Logs Insightsを活用してログ分析を行う。


55. Amazon Kinesisを利用してリアルタイムデータストリーミングを処理する。


56. Amazon Athenaを活用してS3上のデータをSQLで分析する。


57. AWS Glueを利用してETL処理を自動化する。


58. AWS Step Functionsを活用してワークフローを自動化する。


59. AWS Data Pipelineを活用してデータ処理をスケジュールする。


60. Amazon QuickSightを活用してBI（ビジネスインテリジェンス）を実装する。




---

7. セキュリティとコンプライアンス

61. AWS KMS（Key Management Service）を使ってデータを暗号化する。


62. AWS Secrets Managerを活用してAPIキーやパスワードを安全に管理する。


63. AWS IAMのMFA（多要素認証）を有効化する。


64. AWS Security Hubを利用してセキュリティ監視を統合する。


65. AWS Artifactを利用してコンプライアンスレポートを取得する。




---

8. 実践演習

66. マルチリージョン構成のWebアプリを設計する。


67. AWS Well-Architected Frameworkを使ってアーキテクチャを評価する。


68. EC2, S3, RDS, ELBを組み合わせてスケーラブルなWebアプリを構築する。
…


69. AWS Certified Solutions Architect - Associateの模擬試験を受ける。




---

この100本ノックをこなせば、SAA試験対策として十分な知識を習得できます！ 🚀

