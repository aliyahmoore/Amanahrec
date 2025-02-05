# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
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
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    user ||= User.new

    if user.admin?
      can :manage, [Activity, Board, Event, MediaMention, Testimonial]  # Admin can manage all actions
    elsif user.persisted?
      can :create, Testimonial # Signed in users can submit a testimonial
      can :read, [Activity, Event]  
      can :index, [Board, MediaMention] 
    else user
      can :read, [Activity, Event]  # Not signed in users can only read
      can :index, [Board, MediaMention] # Not signed in users can only see the index
    end
  end
end
