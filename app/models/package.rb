class Package < ApplicationRecord

	has_many :contributors_packages
	has_many :contributors, through: :contributors_packages

	validates_presence_of :name
	validates_presence_of :version
	validates_presence_of :title
	validates_presence_of :description
	validates_presence_of :publication_date

	def authors
		contributors.includes(:contributors_packages).where('contributors_packages.role = ?', ContributorsPackage.roles[:author])
	end

	def maintainers
		contributors.includes(:contributors_packages).where('contributors_packages.role = ?', ContributorsPackage.roles[:maintainer])
	end

end
