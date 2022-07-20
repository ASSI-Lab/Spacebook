class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)
    if user.is_admin?
      can :manage, :all
    end

    if user.is_manager?
      if Department.where(manager: user.email).count != 0
        can :manage, Reservation, :dep_name => Department.where(manager: user.email).first.name
        can :destroy, Department, :name => Department.where(manager: user.email).first.name
      end
      can :access, Department
      can :manage, TempDep
      can :manage, TempSp
      can :manage, TempWeekDay
      can :manage, Seat
      can :manage, Space
      can :manage, FavouriteSpace
      can :manage, QuickReservation
    end

    if user.is_user?
      can :manage, Reservation, :email => user.email
      cannot :manage, User
      can :manage, User, :email => user.email
      canont :manage, Department
      cannot :manage, TempDep
      cannot :manage, TempSp
      cannot :manage, TempWeekDay
      cannot :manage, Seat
      cannot :manage, Space
      can :manage, FavouriteSpace
      can :manage, QuickReservation
    end

  end
end
