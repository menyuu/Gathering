class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

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

  def self.search_match(word)
    objects = []
    perfect_match = self.where(text: word).where(status: "published")
    backward_match = self.where("text LIKE ?", "#{word}%").where(status: "published")
    prefix_match = self.where("text LIKE ?", "%#{word}").where(status: "published")
    partial_match = self.where("text LIKE ?", "%#{word}%").where(status: "published")
    objects.push(perfect_match, backward_match, prefix_match, partial_match)
    objects.flatten!
    return unique_objects = objects.uniq { |object| object.id }
  end
end
