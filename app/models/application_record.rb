class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

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
