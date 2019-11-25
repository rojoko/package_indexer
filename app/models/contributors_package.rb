class ContributorsPackage < ApplicationRecord
  belongs_to :contributor
  belongs_to :package

  validates_presence_of :role

  enum role: {
      author: 'author',
      maintainer: 'maintainer'
  }

end