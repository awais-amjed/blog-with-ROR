require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Test User', posts_counter: 0) }

  before { subject.save }

  it 'User is valid' do
    expect(subject).to be_valid
  end

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be an integer greater than or equal to zero' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  context 'Call recent posts on a user' do
    user = User.create(name: 'Test User', posts_counter: 0)
    Post.create(user:, title: 'Hello', comments_counter: 0, likes_counter: 0)
    Post.create(user:, title: 'Hello', comments_counter: 0, likes_counter: 0)
    Post.create(user:, title: 'Hello', comments_counter: 0, likes_counter: 0)
    last_post = Post.create(user:, title: 'Hello', comments_counter: 0, likes_counter: 0)

    it 'should return the last 3 posts by that user' do
      recent_posts = user.recent_posts
      expect(recent_posts.length).to be(3)
      expect(recent_posts.first).to eql(last_post)
    end
  end
end
