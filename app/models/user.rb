class User < ActiveRecord::Base
  has_many :notes
  has_many :viewers
  has_many :readable, :through => :viewers, :source => :note

  def admin?
    self.admin
  end


end
