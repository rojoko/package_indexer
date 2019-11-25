class AddConstraintsToContributor < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL
      alter table contributors add constraint unique_name_email unique (name, email);
      alter table contributors drop constraint unique_email;
    SQL
  end
end
