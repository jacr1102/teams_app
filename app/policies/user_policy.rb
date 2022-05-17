class UserPolicy
  attr_reader :current_user, :user

  def initialize(current_user, user)
    @current_user     = current_user
    @user  = user
  end

  def index?
    !current_user.is_user?
  end

  def show?
    (current_user.is_user? && current_user == user) || !current_user.is_user?
  end

  def destroy?
    !current_user.is_user?
  end


  def create?
    !current_user.is_user?
  end

  def new?
    create?
  end

  def update?
    !current_user.is_user?
  end

  def edit?
    update?
  end


  class Scope
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user     = current_user
      @scope  = scope
    end

    def resolve
      if current_user.is_user?
        raise Pundit::NotAuthorizedError
      else
        scope.all
      end
    end
  end
end