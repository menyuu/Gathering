# require 'rails_helper'

# RSpec.describe 'Postモデルのテスト', type: :model do
#   describe 'バリデーションのテスト' do
#     subject { post.valid? }

#     let(:end_user) { create(:end_user) }
#     let(:post) { build(:post, end_user_id: end_user.id) }
#     let(:image) {build(:post, end_user_id: end_user.id, ) }

#     context 'textカラム' do
#       it '空欄でないこと' do
#         post.text = ''
#         is_expected.to eq false
#       end
#       it '200文字以下であること' do
#         post.text = Faker::Lorem.characters(number: 200)
#         is_expected.to eq true
#       end
#       it '200文字を超えないこと' do
#         post.text = Faker::Lorem.characters(number: 201)
#         is_expected.to eq false
#       end
#     end
#     context 'imageのテスト' do
#       it '画像が複数添付されていること' do
#         post_attached_images.valid?
#         is_expected.to eq true
#       end
#     end
#   end

#   describe 'アソシエーションのテスト' do
#     context 'EndUserモデルとの関係' do
#       it 'N:1となっている' do
#         expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
#       end
#     end
#   end
# end