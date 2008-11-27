class User < ActiveRecord::Base
  validates_presence_of :username, :password, :first_name
  validates_uniqueness_of :username
  
  class << self
    def authenticate(login, password)
      find_by_username_and_password(login, password)
    end
  end
  
  def administrator?
    true
  end
end
