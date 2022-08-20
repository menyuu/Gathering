class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  # 画面上に表示するタグ類
  # タグをつけている人数が多い順にソート
  def self.display_show_type(object, range = 30)
    case object
      when "user"
        where(status: "prepared").sort { |a,b| b.users.size <=> a.users.size}.first(range)
      when "group"
        where(status: "prepared").sort { |a,b| b.groups.size <=> a.groups.size}.first(range)
      when "post"
        all.sort{ |a,b| b.posts.size <=> a.posts.size}.first(range)
    end
  end
  
  # タグ類のformへの表示
  # 持っているタグを表示
  def tag_names
    tags = self.tags
    if tags.count > 0
      # 所持しているタグの数が1つ以上あれば最後に半角カンマ(,)を表示する
      tags.pluck(:name).join(",") + ","
    else
      tags.pluck(:name).join(",")
    end
  end

  # 持っているジャンルを表示
  def genre_names
    genres = self.genres
    if genres.count > 0
      genres.pluck(:name).join(",") + ","
    else
      genres.pluck(:name).join(",")
    end
  end

  def game_names
    games = self.games
    if games.count > 0
      games.pluck(:name).join(",") + ","
    else
      games.pluck(:name).join(",")
    end
  end

  # タグの作成
  # タグを保存
  def tag_save(tags, class_name)
    # 持っているタグを全て削除して、追加する
    self.tags.destroy_all
    tags.uniq.map do |tag|
        # タグが既に存在するかを探して存在しなければ作成する
      tag = class_name.find_or_create_by(name: tag)
      self.tags << tag
    end
  end

  
  
  # 検索用
  # ユーザーとグループのid検索
  def self.search_id_match(word, id)
    # idが存在するかどうかを判定
    if self.exists?(word)
      # 部分テンプレートにeachが存在するため配列にする
      specific_object = []
      # 存在したidを絞り込む
      object = self.where(id: id)
      specific_object << object
      specific_object.flatten!
      return specific_object
    end
  end

  # ユーザーとグループの名称検索
  def self.search_match(word, status)
    objects = []
    # 完全、後方、前方、部分一致のそれぞれから検索し配列に入れる
    perfect_match = self.where(name: word).where(status).with_attached_icon.order(create_at: :DESC)
    backward_match = self.where("name LIKE ?", "#{word}%").where(status).with_attached_icon.order(create_at: :DESC)
    prefix_match = self.where("name LIKE ?", "%#{word}").where(status).with_attached_icon.order(create_at: :DESC)
    partial_match = self.where("name LIKE ?", "%#{word}%").where(status).with_attached_icon.order(create_at: :DESC)
    objects.push(perfect_match, backward_match, prefix_match, partial_match)
    objects.flatten!
    # 重複するデータを削除
    unique_objects = objects.uniq { |object| object.id }
    return unique_objects
  end

  # ユーザーとグループのキーワード検索
  def self.search_keyword_match(word, status)
    objects = []
    # nameとintroductionからそれぞれに一致するデータを抽出
    perfect_match = self.where(name: word).where(status).with_attached_icon.order(create_at: :DESC)
    backward_match = self.where("name LIKE ?", "#{word}%").where(status).with_attached_icon.order(create_at: :DESC)
    prefix_match = self.where("name LIKE ?", "%#{word}").where(status).with_attached_icon.order(create_at: :DESC)
    partial_match = self.where("name LIKE ?", "%#{word}%").where(status).with_attached_icon.order(create_at: :DESC)
    perfect_match_introduction = self.where(introduction: word).where(status).with_attached_icon.order(create_at: :DESC)
    backward_match_introduction = self.where("introduction LIKE ?", "#{word}%").where(status).with_attached_icon.order(create_at: :DESC)
    prefix_match_introduction = self.where("introduction LIKE ?", "%#{word}").where(status).with_attached_icon.order(create_at: :DESC)
    partial_match_introduction = self.where("introduction LIKE ?", "%#{word}%").where(status).with_attached_icon.order(create_at: :DESC)
    objects.push(perfect_match, backward_match, prefix_match, partial_match,
    perfect_match_introduction, backward_match_introduction, prefix_match_introduction, partial_match_introduction)
    objects.flatten!
    unique_objects = objects.uniq { |object| object.id }
    return unique_objects
  end
end
