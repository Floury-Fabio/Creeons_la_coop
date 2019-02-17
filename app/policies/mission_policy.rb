# frozen_string_literal: true

class MissionPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    (user == record.author) || (user.role == 'super_admin')
  end

  def destroy?
    user.role == 'super_admin'
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end