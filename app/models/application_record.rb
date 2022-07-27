class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def tag_save(sent_tags)
    # 現在タグを持っている場合、持っているタグを配列で取り出しcurrent_tagsに格納
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在持っているタグから引数に渡されたタグを取り除きold_tagsに格納
    old_tags = current_tags - sent_tags
    # 引数に渡されたタグから現在持っているタグを取り除きnew_tagsに格納
    new_tags = sent_tags - current_tags
    # old_tagsに格納されたタグをひとつずつ取り出し削除する
    old_tags.each do |old|
      self.tags.delete(Tag.find_by(name: old))
    end
    # new_tagsに格納されたタグをひとつずつ探して存在しなければ新しく作り、self.tagに格納
    new_tags.each do |new|
      tag = Tag.find_or_create_by(name: new)
      self.tags << tag
    end
  end
end
