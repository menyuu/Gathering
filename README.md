# Gathering
___
## サイト概要
### サイトテーマ

ゲーム×趣味から広がるコミュニティSNS

### テーマを選んだ理由

現在、ゲームは老若男女問わずできるものが増えていると感じます。

世界的にはゲーム人口はかなり多く大会なども実施され非常にホットな文化だといえます。

そして日本でもコロナ禍での巣ごもり需要も相まってゲームが趣味の人が増えているように感じ、ゲームというひとつの趣味とほかの趣味を共有する場は非常にニーズのあるものと考えております。
  
また好きなゲームと他の趣味を共有することでより深いコミュニケーションができ濃い関係を構築できるのではないかと考えております。

ゲームを通じて交流し、他の人との趣味を共有...そして新たな趣味の発見があるのではないでしょうか。

### ターゲットユーザ

**メインターゲット**
- ゲーム好きの人
  - ゲーム人口の多い10代から30代が主なターゲット
  - ゲーム以外に何か趣味を持っていること

**その他ユーザー**
- 老若男女問わず
- 配信等でゲームを見る人
- 趣味を共有したい人


### 主な利用シーン

- 趣味を共有できる人を探しているとき
- 誰かと一緒にゲームをしたいとき
- ゲームをプレイしながら談笑したいとき
- ゲームの話をしたいとき
- 誰かとコミュニケーションをとりたいとき
- 時間を忘れてゲームをしたいとき

## 設計書

**ER図**
![Gathering drawio](https://user-images.githubusercontent.com/101458830/180711703-de044303-cce0-4f3a-9c7c-7c220a4137be.png)

___
テーブル定義書
[Gatheringテーブル定義書.pdf](https://github.com/menyuu/Gathering/files/9178521/Gathering.pdf)

___
テスト仕様書
[Gathering_テスト仕様書.xlsx.pdf](https://github.com/menyuu/Gathering/files/9422492/Gathering_.xlsx.pdf)

___

## 開発環境

- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
- その他：Bootstrap, FontAwesome

### gems
 ``` 
   gem 'devise'
   gem 'slim-rails'
   gem 'html2slim'
   gem 'enum_help'
   gem 'devise-i18n'
   gem 'rails-i18n'
 ```
 
 **デバッグ用gem**
 ```
   gem 'pry-rails'
   gem 'annotate'
   gem 'better_errors'
   gem 'binding_of_caller'
   gem 'pry-byebug'  
  ```

## 使用素材

- 通常のSNSツールとして使用するためゲーム等の著作権を侵害する画像などは一切使用しません。
- 投稿機能などに関しても投稿される画像は著作権の侵害に抵触する可能性があるためゲーム等のキャプチャなどの利用を原則禁止、ご自身で撮影された内容等を投稿していただく目的とさせていただきます。

ユーザーアイコン・グループアイコン素材：ICOOON MONO(https://icooon-mono.com/)
