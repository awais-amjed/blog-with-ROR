require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.new(name: 'Test User', posts_counter: 0)
  subject { Post.new(user:, title: 'Hello', comments_counter: 0, likes_counter: 0) }

  before { subject.save }

  it 'Post is valid' do
    expect(subject).to be_valid
  end

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be an integer greater than or equal to zero' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be an integer greater than or equal to zero' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  context 'Call recent comments on a post' do
    post = Post.create(user:, title: 'Test', comments_counter: 0, likes_counter: 0)
    5.times { Comment.create(post:, user:, text: 'Hello') }
    last_comment = Comment.create(post:, user:, text: 'Last one')

    it 'should return the last 5 comments on the post' do
      recent_comments = post.recent_comments
      expect(recent_comments.length).to be(5)
      expect(recent_comments.first).to eql(last_comment)
    end
  end
end
