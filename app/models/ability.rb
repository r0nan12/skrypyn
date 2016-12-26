class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.author?
      authors_ability(user)
    elsif user.follower?
      follower_ability(user)
    else
      can :index, Article
    end
  end

  def authors_ability(user)
    can :read, [Article, Coment], user_id: user.id
    can :create, [Article, Coment, Order]
    can [:update, :destroy], [Article, Coment], user_id: user.id
  end

  def follower_ability(user)
    authors_ability(user)
    user.orders.each do |order|
      can :read, Article, id: order.article_id
    end
  end
end
