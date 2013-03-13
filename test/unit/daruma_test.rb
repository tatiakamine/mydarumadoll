require 'test_helper'

class DarumaTest < ActiveSupport::TestCase
  # CREATE

  test "should create daruma" do
    daruma = Daruma.new
    daruma.left_eye = false
    daruma.right_eye = false
    daruma.user = users(:tati)
    daruma.sender = users(:edna)
    daruma.status = Daruma::STATUS_CREATED
    daruma.token = TokenSingleton.instance.generateToken
    assert daruma.save, "Did not create daruma"
  end

  test "should create daruma, user and sender" do
    daruma = Daruma.new
    daruma.left_eye = false
    daruma.right_eye = false
    daruma.new_user_email = 'mark@facebook.com'
    daruma.new_sender_name = 'Steve Jobs'
    daruma.new_sender_email = 'steve@apple.com'
    daruma.status = Daruma::STATUS_CREATED
    daruma.token = TokenSingleton.instance.generateToken
    assert daruma.save, "Did not create daruma with user and sender"
    users = User.where(:email => 'mark@facebook.com')
    assert_equal users.length, 1, "Did not create user for daruma"
    assert_equal users[0], daruma.user, "Did not associate correct user for daruma"
    senders = User.where(:email => 'steve@apple.com')
    assert_equal senders.length, 1, "Did not create sender for daruma"
    assert_equal senders[0], daruma.sender, "Did not associate correct sender for daruma"
    users = User.all
  end

  test "should create daruma and associate existing user and sender" do
    daruma = Daruma.new
    daruma.left_eye = false
    daruma.right_eye = false
    daruma.new_user_email = 'tatiana.akamine@gmail.com'
    daruma.new_sender_name = 'Edna Utima'
    daruma.new_sender_email = 'edna.akamine@gmail.com'
    daruma.status = Daruma::STATUS_CREATED
    daruma.token = TokenSingleton.instance.generateToken
    assert daruma.save, "Did not create daruma with existing user and sender"
    users = User.where(:email => 'tatiana.akamine@gmail.com')
    assert_equal users.length, 1, "Created user that already existed"
    assert_equal users[0], daruma.user, "Did not associate correct user for daruma"
    senders = User.where(:email => 'edna.akamine@gmail.com')
    assert_equal senders.length, 1, "Created sender that already existed"    
    assert_equal senders[0], daruma.sender, "Did not associate correct sender for daruma"
  end


  test "should not save daruma without right_eye" do
    daruma = Daruma.new
    daruma.left_eye = false
    daruma.user = users(:tati)
    daruma.sender = users(:edna)
    daruma.status = Daruma::STATUS_CREATED
    daruma.token = TokenSingleton.instance.generateToken
    assert !daruma.save, "Saved daruma without right_eye"
  end

  test "should not save daruma without left_eye" do
    daruma = Daruma.new
    daruma.right_eye = false
    daruma.user = users(:tati)
    daruma.sender = users(:edna)
    daruma.status = Daruma::STATUS_CREATED
    daruma.token = TokenSingleton.instance.generateToken
    assert !daruma.save, "Saved daruma without left_eye"
  end
  
  test "should not save daruma without user" do
    daruma = Daruma.new
    daruma.left_eye = false
    daruma.right_eye = false
    daruma.sender = users(:edna)
    daruma.status = Daruma::STATUS_CREATED
    daruma.token = TokenSingleton.instance.generateToken
    assert !daruma.save, "Saved daruma without user"
  end
    
  test "should not save daruma without sender" do
    daruma = Daruma.new
    daruma.left_eye = false
    daruma.right_eye = false
    daruma.user = users(:tati)
    daruma.status = Daruma::STATUS_CREATED
    daruma.token = TokenSingleton.instance.generateToken
    assert !daruma.save, "Saved daruma without sender"
  end
  
  test "should not create daruma without status" do
    daruma = Daruma.new
    daruma.left_eye = false
    daruma.right_eye = false
    daruma.user = users(:tati)
    daruma.sender = users(:edna)
    daruma.token = TokenSingleton.instance.generateToken
    assert !daruma.save, "Saved daruma without status"
  end

  test "should not create daruma with invalid status" do
    daruma = Daruma.new
    daruma.left_eye = false
    daruma.right_eye = false
    daruma.user = users(:tati)
    daruma.sender = users(:edna)
    daruma.status = -1
    daruma.token = TokenSingleton.instance.generateToken
    assert !daruma.save, "Saved daruma with invalid status"
  end

  test "should not create daruma without token" do
    daruma = Daruma.new
    daruma.left_eye = false
    daruma.right_eye = false
    daruma.user = users(:tati)
    daruma.sender = users(:edna)
    daruma.status = Daruma::STATUS_CREATED
    assert !daruma.save, "Saved daruma without token"
  end

  # UPDATE
  test "should update daruma" do
    daruma = Daruma.first
    assert daruma.save, "Did not update daruma"
  end

  test "should not update daruma without right_eye" do
    daruma = Daruma.first
    daruma.right_eye = nil
    assert !daruma.save, "Updated daruma with null right_eye"
  end  

  test "should not update daruma without left_eye" do
    daruma = Daruma.first
    daruma.left_eye = nil
    assert !daruma.save, "Updated daruma with null left_eye"
  end  

  test "should not update daruma without user" do
    daruma = Daruma.first
    daruma.user = nil
    assert !daruma.save, "Updated daruma without user"
  end  
  
  test "should not update daruma with invalid user" do
    daruma = Daruma.first
    daruma.user_id = -1
    assert !daruma.save, "Updated daruma with invalid user"
  end

  test "should not update daruma without sender" do
    daruma = Daruma.first
    daruma.sender = nil
    assert !daruma.save, "Updated daruma without sender"
  end  
  
  test "should not update daruma with invalid sender" do
    daruma = Daruma.first
    daruma.sender_id = -1
    assert !daruma.save, "Updated daruma with invalid sender"
  end
  
  test "should not update daruma without status" do
    daruma = Daruma.first
    daruma.status = nil
    assert !daruma.save, "Updated daruma without status"
  end

  test "should not update daruma with invalid status" do
    daruma = Daruma.first
    daruma.status = -1
    assert !daruma.save, "Updated daruma with invalid status"
  end

  test "should not update daruma without token" do
    daruma = Daruma.first
    daruma.token = nil
    assert !daruma.save, "Updated daruma without token"
  end

end
