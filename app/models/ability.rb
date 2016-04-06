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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    alias_action :index, to: :access

    can :access, :dashboard
    can :update_yaybar_hidden_state, :dashboard
    can :manage, Conversation
    can :manage, Message

    user ||= User.new
    if user.is? :super_admin
      can :manage, :all
    elsif user.is? :club_admin
      can :add, :coach
      can :add, :player
      can :manage, Club
    elsif user.is? :coach
      can :add, :player
      can :manage, MatchCategory
      can :manage, Match
      can :manage, Video
      can :manage, ClipCategory
      can :manage, Clip
      can :manage, Playlist
      can :players, Club
    elsif user.is? :player
      can :for_me, Clip
      can :log_player_activity_on, Clip
      can :stats, Match
    else
    end
  end
end
