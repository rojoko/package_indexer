class Package < ApplicationRecord
	has_many :contributors, :through => :contributors_packages

	validates_presence_of :name
	validates_presence_of :version
	validates_presence_of :title
	validates_presence_of :description
	validates_presence_of :publication_date

end
