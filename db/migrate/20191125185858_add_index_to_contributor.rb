class AddIndexToContributor < ActiveRecord::Migration[6.0]
  def change
    add_index :contributors, :email
  end
end
