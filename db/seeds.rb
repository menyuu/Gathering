# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Admin.create(
  email: "admin@admin",
  password: "AEIO4310"
  )

5.times do |n|
  EndUser.create(
    name: "ユーザー#{n * 1}",
    email: "test#{n * 1}@test#{n * 1}",
    password: "test#{111 * n}"
  )
end

# 趣味タグ一覧
Tag.create(name: "ゲーム", status: 0)

Tag.create(name: "映画鑑賞", status: 0)

Tag.create(name: "読書", status: 0)

Tag.create(name: "アニメ", status: 0)

Tag.create(name: "酒", status: 0)

Tag.create(name: "料理", status: 0)

Tag.create(name: "写真", status: 0)

Tag.create(name: "スポーツ", status: 0)

Tag.create(name: "音楽", status: 0)

Tag.create(name: "旅行", status: 0)

Tag.create(name: "DIY", status: 0)

Tag.create(name: "キャンプ", status: 0)

Tag.create(name: "散歩", status: 0)

Tag.create(name: "登山", status: 0)

Tag.create(name: "釣り", status: 0)

Tag.create(name: "筋トレ", status: 0)

Tag.create(name: "ヨガ", status: 0)

Tag.create(name: "アロマテラピー", status: 0)

Tag.create(name: "ドライブ", status: 0)

Tag.create(name: "バイク", status: 0)

Tag.create(name: "温泉", status: 0)

Tag.create(name: "スポーツ観戦", status: 0)

Tag.create(name: "英会話", status: 0)

Tag.create(name: "寺社仏閣巡り", status: 0)

Tag.create(name: "ドラマ", status: 0)

Tag.create(name: "カフェ巡り", status: 0)

Tag.create(name: "サバゲー", status: 0)

Tag.create(name: "ハンドメイド", status: 0)

Tag.create(name: "資格取得", status: 0)

Tag.create(name: "プログラミング", status: 0)

# ジャンル一覧
Genre.create(name: "アクション", status: 0)

Genre.create(name: "シューティング", status: 0)

Genre.create(name: "シミュレーション", status: 0)

Genre.create(name: "レーシング", status: 0)

Genre.create(name: "アドベンチャー", status: 0)

Genre.create(name: "RPG", status: 0)

Genre.create(name: "パズル", status: 0)

Genre.create(name: "音楽", status: 0)

Genre.create(name: "トレーディングカード", status: 0)

Genre.create(name: "FPS", status: 0)

Genre.create(name: "TPS", status: 0)

Genre.create(name: "フライトシューティング", status: 0)

Genre.create(name: "プラットフォームゲーム", status: 0)

Genre.create(name: "対戦アクションゲーム", status: 0)

Genre.create(name: "対戦型格闘ゲーム", status: 0)

Genre.create(name: "MMORPG", status: 0)

Genre.create(name: "シミュレーションRPG", status: 0)

Genre.create(name: "タワーディフェンス", status: 0)

Genre.create(name: "育成ゲーム", status: 0)

Genre.create(name: "箱庭ゲーム", status: 0)

Genre.create(name: "ボードゲーム", status: 0)

Genre.create(name: "コンシューマーゲーム", status: 0)

Genre.create(name: "スマホゲーム", status: 0)

Genre.create(name: "PCゲーム", status: 0)

Genre.create(name: "アーケードゲーム", status: 0)

Genre.create(name: "VR", status: 0)

Genre.create(name: "インディーゲーム", status: 0)

Genre.create(name: "洋ゲー", status: 0)

Genre.create(name: "協力プレイ", status: 0)

Genre.create(name: "レトロゲーム", status: 0)

Genre.create(name: "ホラーゲーム", status: 0)

# ゲーム一覧
# 30.times do |n|
#   Game.create(
#     name: "ゲーム#{n + 1}",
#     status: 0
#     )
# end

Game.create(name: "FINAL FANTASY XIV", status: 0)

Game.create(name: "黒い砂漠", status: 0)

Game.create(name: "LOST ARK", status: 0)

Game.create(name: "VALORANT", status: 0)

Game.create(name: "Apex Legends", status: 0)

Game.create(name: "FORTNITE", status: 0)

Game.create(name: "Sid Meier’s Civilization VI", status: 0)

Game.create(name: "Dead by Daylight", status: 0)

Game.create(name: "Grand Theft Auto V", status: 0)

Game.create(name: "ポケットモンスター", status: 0)

Game.create(name: "ドラゴンクエスト", status: 0)

Game.create(name: "ファイナルファンタジー", status: 0)

Game.create(name: "マリオシリーズ", status: 0)

Game.create(name: "星のカービィ", status: 0)

Game.create(name: "ゼルダの伝説", status: 0)

Game.create(name: "モンスターハンター", status: 0)

Game.create(name: "バイオハザード", status: 0)

Game.create(name: "メタルギアソリッド", status: 0)

Game.create(name: "無双シリーズ", status: 0)

Game.create(name: "キングダムハーツ", status: 0)

Game.create(name: "テイルズ　オブシリーズ", status: 0)

Game.create(name: "ペルソナ", status: 0)

Game.create(name: "ウイニングイレブン", status: 0)

Game.create(name: "パワフルプロ野球", status: 0)

Game.create(name: "グランツーリスモ", status: 0)

Game.create(name: "ストリートファイター", status: 0)

Game.create(name: "鉄拳", status: 0)

Game.create(name: "ガンダムシリーズ", status: 0)

Game.create(name: "スーパーロボット大戦", status: 0)

Game.create(name: "三國志", status: 0)

Game.create(name: "どうぶつの森", status: 0)

Game.create(name: "テトリス", status: 0)

Game.create(name: "ぷよぷよ", status: 0)

Game.create(name: "太鼓の達人", status: 0)

Game.create(name: "ぷよぷよ", status: 0)

Game.create(name: "桃太郎電鉄", status: 0)

Game.create(name: "龍が如く", status: 0)

Game.create(name: "牧場物語", status: 0)

Game.create(name: "信長の野望", status: 0)

Game.create(name: "アトリエシリーズ", status: 0)

Game.create(name: "原神", status: 0)

Game.create(name: "クロノ・トリガー", status: 0)

Game.create(name: "MOTHER", status: 0)

Game.create(name: "ヴァルキリープロファイル", status: 0)

Game.create(name: "リングフィット アドベンチャー", status: 0)

Game.create(name: "大乱闘スマッシュブラザーズ", status: 0)

Game.create(name: "遊戯王", status: 0)

Game.create(name: "スプラトゥーン", status: 0)

Game.create(name: "デュエルマスターズ", status: 0)

Game.create(name: "マジック：ザ・ギャザリング", status: 0)
