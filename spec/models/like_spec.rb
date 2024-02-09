require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:author) { User.create(name: 'Post Author') }
  let(:user) { User.create(name: 'Liker') }
  let(:post) { Post.create(title: 'New test post', text: 'Test text for this new post', author:) }
  subject(:like) { described_class.create(user: author, post:) }

  def attr_mod(mod, obj: like)
    obj[mod.keys.first] = mod.values.first
    obj
  end

  describe ".new 'Like' is valid only:" do
    it '- with valid attributes' do
      expect(like).to be_valid
      expect(attr_mod({ user_id: nil })).to_not be_valid
      expect(attr_mod({ post_id: nil })).to_not be_valid
    end
  end

  describe '* methods' do
    describe '#update_likes_counter' do
      context "- when 'called'" do
        it "> should refresh the 'likes_counter'" do
          post.likes_counter = nil
          expect(post.likes_counter).to be_nil
          like.update_likes_counter
          expect(post.likes_counter).to eq(1)
        end
      end

      context "- when a 'Like' is created" do
        it "> should refresh 'likes_counter' increased by 1" do
          Like.create(user:, post: like.post)
          expect(post.likes_counter).to eq(like.post.likes_counter)
        end
      end

      context "- when a 'Like' is deleted" do
        it "> should refresh 'likes_counter' decreased by 1" do
          Like.destroy(like.id)
          expect(post.likes_counter).to eq(like.post.likes_counter)
        end
      end
    end
  end

  describe '* associations' do
    context '.user' do
      it "=> responds for belongs to an 'user'" do
        association = described_class.reflect_on_association(:user)
        expect(association.macro).to eq(:belongs_to)
      end
    end

    context '.post' do
      it "=> responds for belongs to a 'post'" do
        association = described_class.reflect_on_association(:post)
        expect(association.macro).to eq(:belongs_to)
      end
    end
  end
end
