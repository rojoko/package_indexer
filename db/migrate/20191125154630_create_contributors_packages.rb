class CreateContributorsPackages < ActiveRecord::Migration[6.0]
  def change

    execute <<-DDL
          CREATE TYPE contributing_role AS ENUM (
            'author', 'maintainer'
          );
    DDL

    create_table :contributors_packages do |t|
      t.belongs_to :contributor
      t.belongs_to :package
      t.column :role, :contributing_role
      t.timestamps
    end

  end
end
