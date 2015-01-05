class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
       user.roles.each { |role| send(role.name.downcase) }
      #if user.has_role? :staff
      #   can :read, Company 
      #   can :update, Company 
      #   can :destroy, Company 
      #   can :create, Company
      #   can :read, Certificate
      #   can :update, Certificate
      #   can :create, Certificate
      #   can :issue, Certificate
      #   can :ready_for_approval, Certificate
      #elsif user.has_role? :director
      #   can :read, Company  
      #   can :read, Certificate  
      #   can :director_accept, Certificate
      #   can :director_reject, Certificate
      #elsif user.has_role? :minister
      #    can :read, Company 
      #    can :read, Certificate     
      #    can :minister_accept, Certificate
      #    can :minister_reject, Certificate
          #can :approve, Company   
          #can :reject, Company 
          #can :read, Company    
      # end
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
  end


  def staff
    can :read, Company 
    can :update, Company 
    can :destroy, Company 
    can :create, Company
    can :read, Certificate
    can :update, Certificate
    can :create, Certificate
    can :issue, Certificate
    can :ready_for_approval, Certificate
  end
  def director
    can :read, Company  
    can :read, Certificate  
    can :director_accept, Certificate
    can :director_reject, Certificate
  end
  def minister
    can :read, Company 
    can :read, Certificate     
    can :minister_accept, Certificate
    can :minister_reject, Certificate
  end

  def super_admin
   can :manage, :all 
   can :read, Company 
  end

  def admin
     can :manage, :all
     can :read, Company 
  end

end
