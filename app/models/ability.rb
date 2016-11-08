class Ability
  include CanCan::Ability

  def initialize(user)

    @user = user || User.new(role_id:3)

        if @user.role.name == 'admin'
          can :manage, :all
        elsif @user.role.name == 'author'
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


         elsif @user.role.name == 'guest'
          can :read, [Article, Coment]
        end

  end



  end

