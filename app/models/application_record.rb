class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.display_show_type(object, range = 30)
    case object
      when "user"
        where(status: "prepared").sort { |a,b| b.users.size <=> a.users.size}.first(range)
      when "group"
        where(status: "prepared").sort { |a,b| b.groups.size <=> a.groups.size}.first(range)
      when "post"
        sort{ |a,b| b.groups.size <=> a.groups.size}.first(range)
    end
  end
end
