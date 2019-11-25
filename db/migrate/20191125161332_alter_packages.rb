class AlterPackages < ActiveRecord::Migration[6.0]
  def change
    change_column :packages, :name, :string, null: false
    change_column :packages, :version, :string, null: false
    change_column :packages, :title, :string, null: false
    change_column :packages, :publication_date, :datetime, null: false
  end
end
