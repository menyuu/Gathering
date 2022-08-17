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

  # ユーザーとグループの名称検索
  def self.search_match(word, status)
    objects = []
    perfect_match = self.where(name: word).where(status).with_attached_icon.order(create_at: :DESC)
    backward_match = self.where("name LIKE ?", "#{word}%").where(status).with_attached_icon.order(create_at: :DESC)
    prefix_match = self.where("name LIKE ?", "%#{word}").where(status).with_attached_icon.order(create_at: :DESC)
    partial_match = self.where("name LIKE ?", "%#{word}%").where(status).with_attached_icon.order(create_at: :DESC)
    objects.push(perfect_match, backward_match, prefix_match, partial_match)
    objects.flatten!
    unique_objects = objects.uniq { |object| object.id }
    return unique_objects
  end

  # ユーザーとグループのキーワード検索
  def self.search_keyword_match(word, status)
    objects = []
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
