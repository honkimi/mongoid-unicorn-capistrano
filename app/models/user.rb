class User
  include Mongoid::Document
  # initialize fields by sorcery
  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_uniqueness_of   :email
  validates_presence_of     :email
end
