# frozen_string_literal: true

class TodoPolicy < ApplicationPolicy
  def index?
    current_user.present?
  end

  def create?
    current_user.present?
  end

  def destroy?
    record.user == current_user
  end
end
