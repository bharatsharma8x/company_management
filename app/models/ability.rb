class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.admin?
      can :manage, :all
    elsif user.employee?
      can :read, :all
      # Add more abilities for local_user if needed
    end
  end
end