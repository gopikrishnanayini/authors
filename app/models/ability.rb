class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :super_admin
      can :manage, :all
    elsif user.has_role? :licensee_admin
      can :create, User
      can :manage, User, :licensee_id => user.id
    end
  end
end
