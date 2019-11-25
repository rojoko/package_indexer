class AlterContributors < ActiveRecord::Migration[6.0]
  def change
    change_column :contributors, :name, :string, null: false
    change_column :contributors_packages, :role, :contributing_role, null: false
  end
end
