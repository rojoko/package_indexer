class CreatePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :packages do |t|
    	t.string :name
    	t.string :version
    	t.string :title
    	t.text :description
    	t.datetime :publication_date
    	t.timestamps
    end

    add_index :packages, :name
    add_index :packages, :version
    add_index :packages, :publication_date
  end
end
