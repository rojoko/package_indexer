class AddUniqueConstraints < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL
      alter table packages add constraint unique_name_version unique (name, version);
      alter table contributors add constraint unique_email unique (email);
      alter table contributors_packages add constraint unique_package_contributor_role unique (package_id, contributor_id, role);
    SQL
  end
end
