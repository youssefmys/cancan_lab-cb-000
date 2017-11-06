class Ability
  include CanCan::Ability

  def initialize(user)

      user ||= user.new

      can :manage, Note, {user_id: user.id}

#      if user.admin?
#        can :manage, :all                    #admin can perform any action for all objects
#      end
#
#      can :create, Note                      #any authenticated user can create notes
#      can :update, Note, :user_id => user.id #owner can update or edit his notes
      can :read, Note do |note|              #note is readable for readers and note owner
        note.readers.include?(user) || note.user == user
      end


  end

end
