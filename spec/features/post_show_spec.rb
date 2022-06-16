require 'rails_helper'
require_relative '../features_helper'

describe 'Post Show' do
  before do
    @name = 'user'
    @user = FeaturesHelper.create_and_activate_user(@name)
    @post = FeaturesHelper.create_posts_for_user(@user).first
    @comments = FeaturesHelper.create_comments_for_post_by_user(@post, @user, count: 2)

    visit user_post_path(@user, @post)
  end

  it 'shows username' do
    expect(page).to have_content @user.name
  end

  it 'shows a post\'s title' do
    expect(page).to have_content @post.title
  end

  it 'shows some of the post\'s body' do
    expect(page).to have_content @post.text
  end

  it 'shows all comments on the post' do
    @comments.each { |comment| expect(page).to have_content comment.text }
  end

  it 'shows username of the commenter' do
    @comments.each { |comment| expect(page).to have_content comment.user.name }
  end

  it 'shows how many comments the post has' do
    expect(page).to have_content 'Comments 2'
  end

  it 'shows how many likes the post has' do
    expect(page).to have_content 'Likes 0'
  end
end
