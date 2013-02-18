class Daruma < ActiveRecord::Base
  attr_accessible :left_eye, :right_eye, :new_user_email, :new_sender_name, :new_sender_email, :captcha

  belongs_to :user, :inverse_of => :darumas
  belongs_to :sender, :inverse_of => :sent_darumas, :class_name => "User"

  attr_accessor :new_user_email, :new_sender_name, :new_sender_email, :captcha

  validates_inclusion_of :left_eye, :in => [true, false]
  validates_inclusion_of :right_eye, :in => [true, false]
  validates :user, :presence => "true"
  validates :sender, :presence => "true"
      
  before_validation :create_nested_user, :create_nested_sender

  def create_nested_user
    logger.info "create_nested_user start"
    create_user(:email => new_user_email) unless new_user_email.blank?
    logger.info "create_nested_user end"
  end
  
  def create_nested_sender
    logger.info "create_nested_sender start"
    create_sender(:name => new_sender_name, :email => new_sender_email) unless (new_sender_email.blank? or new_sender_name.blank?)
    logger.info "create_nested_sender end"
  end
  
end
