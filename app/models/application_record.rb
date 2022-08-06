class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def self.display_show_type(object)
    case object
      when "user"
        where(status: "prepared").sort {|a,b| b.users.size <=> a.users.size}.first(30)
      when"group"
        where(status: "prepared").sort {|a,b| b.groups.size <=> a.groups.size}.first(30)
    end
  end
end
