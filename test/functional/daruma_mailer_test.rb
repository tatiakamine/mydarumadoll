require 'test_helper'

class DarumaMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def test_create_daruma_email
    user = users(:tati)
    sender = users(:edna)

    # Send the email, then test that it got queued
    email = DarumaMailer.create_daruma_email(sender, user).deliver
    assert !ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal [user.email], email.to
    assert_equal "Voce ganhou um Daruma!", email.subject
    #TODO assert_match(/<p>Seu (sua) amigo(a) #{sender.name} te presenteou com um Daruma.<\/p>/, email.encoded)
    #TODO email TXT assert_match(/Welcome to example.com, #{user.name}/, email.encoded)
  end

end
