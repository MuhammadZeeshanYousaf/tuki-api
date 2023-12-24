# See the wiki for details:
# https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

class ApplicationAbility
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the common/regular user here.
    @community = user.community

    can :read, :user
    cannot :manage, :admin
    can :manage, User, id: user.id
    can :read, Event, community: @community
  end
end
