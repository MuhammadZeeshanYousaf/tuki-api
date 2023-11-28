# See the wiki for details:
# https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

class ApplicationAbility
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the common/regular user here.

    can :read, :user
    cannot :manage, :admin
  end
end
