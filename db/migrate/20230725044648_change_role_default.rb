# frozen_string_literal: true

class ChangeRoleDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :role, 0
  end
end
