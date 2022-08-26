# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'EndUserモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { end_user.valid? }

    let(:end_user) { build(:end_user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        end_user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること' do
        end_user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq true
      end
      it '30文字以下であること' do
        end_user.name = Faker::Lorem.characters(number: 30)
        is_expected.to eq true
      end
      it '30文字を超えないこと' do
        end_user.name = Faker::Lorem.characters(number: 31)
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '240文字以下であること' do
        end_user.introduction = Faker::Lorem.characters(number: 240)
        is_expected.to eq true
      end
      it '240文字を超えないこと' do
        end_user.introduction = Faker::Lorem.characters(number: 2411)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(EndUser.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end