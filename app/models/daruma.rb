# encoding: utf-8
class Daruma < ActiveRecord::Base
  
  STATUS_CREATED = 1
  STATUS_SENT = 2
  ALL_DARUMA_STATUSES = [STATUS_CREATED, STATUS_SENT]
  
  attr_accessible :left_eye, :right_eye, :new_user_email, :new_sender_name, :new_sender_email, :captcha, :status, :token

  belongs_to :user, :inverse_of => :darumas
  belongs_to :sender, :inverse_of => :sent_darumas, :class_name => "User"

  attr_accessor :new_user_email, :new_sender_name, :new_sender_email, :captcha

  validates :user_id, :sender_id, :token, :presence => true
  validates :right_eye, :left_eye, :inclusion => { :in => [false, true], :message => "%{value} is not a valid eye value" }
  validates :status, :inclusion => { :in => ALL_DARUMA_STATUSES, :message => "%{value} is not a valid status" }
  validates_associated :user, :sender
      
  before_validation :create_nested_user, :create_nested_sender

  def create_nested_user
    if (not new_user_email.blank?)
      #TODO find user
      create_user(:email => new_user_email)
    else
      if (user.blank?)
        self.errors.add(:new_user_email, "O e-mail do presenteado é obrigatório")
      end
    end
  end
  
  def create_nested_sender
    #TODO find sender
    create_sender(:name => new_sender_name, :email => new_sender_email) unless new_sender_email.blank? or new_sender_name.blank?

    if (new_sender_email.blank? and sender.blank?)
      self.errors.add(:new_sender_email, "O seu e-mail é obrigatório")
    end
    
    if (new_sender_name.blank? and sender.blank?)
      self.errors.add(:new_sender_name, "O seu nome é obrigatório")
    end
    
  end
  
end
