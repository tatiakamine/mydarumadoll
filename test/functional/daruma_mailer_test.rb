#encoding: utf-8
require 'test_helper'

class DarumaMailerTest < ActionMailer::TestCase
  
  def test_create_daruma_email
    user = users(:tati)
    sender = users(:edna)

    # Send the email, then test that it got queued
    email = DarumaMailer.create_daruma_email(sender, user).deliver
    assert !ActionMailer::Base.deliveries.empty?

    # Test if the body of the sent email contains what we expect it to
    assert_equal ["daruma@mydarumadoll.com"], email.from
    assert_equal [user.email], email.to
    assert_equal "Você ganhou um Daruma!", email.subject
    #TODO assert_match(/<p>Seu (sua) amigo(a) #{sender.name} te presenteou com um Daruma.<\/p>/, email.encoded)
    #TODO email TXT assert_match(/Welcome to example.com, #{user.name}/, email.encoded)
  end
  
  def test_create_confirmation_email
    daruma = darumas(:none)

    # Send the email, then test that it got queued
    email = DarumaMailer.create_confirmation_email(daruma.sender, daruma.user, daruma.id, daruma.token).deliver
    assert !ActionMailer::Base.deliveries.empty?

    # Test if the body of the sent email contains what we expect it to
    assert_equal ["daruma@mydarumadoll.com"], email.from
    assert_equal [daruma.sender.email], email.to
    assert_equal "Você enviou um Daruma?", email.subject
    
    #TODO email TXT assert_match(/Welcome to example.com, #{user.name}/, email.encoded)    
  end

end
