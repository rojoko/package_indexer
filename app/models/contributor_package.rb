class ContributorPackage < ApplicationRecord
  belongs_to :contributor
  belongs_to :package

  validates_presence_of :name

  enum role: {
      author: 'author',
      maintainer: 'maintainer'
  }

end