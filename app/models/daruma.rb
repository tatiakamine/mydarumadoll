# encoding: utf-8
class Daruma < ActiveRecord::Base
  
  STATUS_CREATED = 1
  STATUS_SENT = 2
  ALL_DARUMA_STATUSES = [STATUS_CREATED, STATUS_SENT]
  
  attr_accessible :left_eye, :right_eye, :new_user_email, :new_sender_name, :new_sender_email, :captcha, :status

  belongs_to :user, :inverse_of => :darumas
  belongs_to :sender, :inverse_of => :sent_darumas, :class_name => "User"

  attr_accessor :new_user_email, :new_sender_name, :new_sender_email, :captcha, :status

  validates_inclusion_of :left_eye, :in => [true, false]
  validates_inclusion_of :right_eye, :in => [true, false]
  validates :user, :presence => "true"
  validates :sender, :presence => "true"
  validates_inclusion_of :status, :in => ALL_DARUMA_STATUSES
  validates :status, :presence => "true"
      
  before_validation :create_nested_user, :create_nested_sender

  def create_nested_user
    if (not new_user_email.blank?)
      create_user(:email => new_user_email)
    else
      self.errors.add(:new_user_email, "O e-mail do presenteado é obrigatório")
    end
  end
  
  def create_nested_sender

    create_sender(:name => new_sender_name, :email => new_sender_email) unless new_sender_email.blank? or new_sender_name.blank?

    if (new_sender_email.blank?)
      self.errors.add(:new_sender_email, "O seu e-mail é obrigatório")
    end
    
    if (new_sender_name.blank?)
      self.errors.add(:new_sender_name, "O seu nome é obrigatório")
    end
    
  end
  
end
