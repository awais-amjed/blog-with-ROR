# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Post
    can :read, User
    return unless user.present?
    can :manage, Post, user_id: user.id
    return unless user.is? :admin
    can :manage, :all
  end
end
