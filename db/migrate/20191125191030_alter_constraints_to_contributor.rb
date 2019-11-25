class AlterConstraintsToContributor < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL
      alter table contributors add constraint unique_email unique (email);
      alter table contributors drop constraint unique_name_email;
    SQL

    add_index :contributors, :name
    remove_index :contributors, name: :index_contributors_on_email
  end
end
