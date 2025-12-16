class RecipePolicy < ApplicationPolicy
  def edit?
    user == record.user
  end

  def update?
    user == record.user
  end

  def destroy?
    user == record.user
  end
end