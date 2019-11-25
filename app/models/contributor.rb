class Contributor < ApplicationRecord
  has_many :packages, :through => :contributors_packages

  validates_presence_of :name
end