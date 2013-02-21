require 'test_helper'

class DarumaTest < ActiveSupport::TestCase
  # CREATE
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
