class Ability
  include CanCan::Ability

  def initialize(user)
    @role = Role.new
    user ||= @role.users.build


        if user.role? == 'admin'
          can :manage, :all
        elsif user.role? == 'author'
          can :read, :all
          can :create, [Article, Coment]
          can :update, Article do |article|
            article.try(:user) == user
          end
          can :update, Coment do |coment|
            coment.try(:user) == user
          end
          can :destroy, Article do |article|
            article.try(:user) == user
          end
          can :destroy, Coment do |coment|
            coment.try(:user) == user
          end

        end
  else
    can :read, [Article, Coment]

          end



  end

