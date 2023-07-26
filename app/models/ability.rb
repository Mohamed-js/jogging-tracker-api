class Ability
  include CanCan::Ability

  def initialize(user)
    return can :manage, JoggingTime, user_id: user.id if user.regular_user?
    return can :manage, User if user.user_manager?
    return can :manage, :all if user.admin?
  end
end
