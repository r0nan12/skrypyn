class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if User.admin?(user)
      can :manage, :all
    elsif User.author?(user)
      authors_ability(user)
      else
        can :read, [Article, Coment]
    end
  end

  def authors_ability(user)
    can :read, :all
    can :create, [Article, Coment]
    can :update, [Article, Coment] do |article, coment|
      coment.try(:user_id) == user.id
      article.try(:user_id) == user.id
    end
    can :destroy, [Article, Coment] do |article, coment|
      coment.try(:user_id) == user.id
      article.try(:user_id) == user.id
    end
  end
end
