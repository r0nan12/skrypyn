class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.author?
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
