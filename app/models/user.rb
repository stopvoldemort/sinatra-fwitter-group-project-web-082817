class User < ActiveRecord::Base
  has_many :tweets

  def slug
    self.username.gsub(/\s/, "-")
  end

  def self.find_by_slug(slug)
    User.find_by(username: slug.gsub(/-/, " "))
  end

  def authenticate(password)
    @user = User.find_by(password: password)
    @user ? @user : false
  end
end
