class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
        if user.role? :admin
          can :manage, :all
        elsif user.role? :author
          can :read, :all
          can :create, [Article, Coment]
          can :update, [Article,Coment] do |article, coment|
            coment.try(:user_id)==user.id
            article.try(:user_id)==user.id
          end
          can :destroy, [Article,Coment] do |article,coment|
            article.try(:user_id)==user.id
            coment.try(:user_id)==user.id
          end
         else
          can :read, [Article, Coment]
        end
  end
end

