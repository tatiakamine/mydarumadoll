class User < ActiveRecord::Base
  attr_accessible :email, :name

  validates :email, :presence => true
  validates :email, :uniqueness => { :case_sensitive => false }
  
  has_many :darumas, :inverse_of => :user  
  has_many :sent_darumas, :inverse_of => :sender, :class_name => "Daruma"
  
end
