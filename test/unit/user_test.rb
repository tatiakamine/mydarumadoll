require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  # CREATE
  test "should not save user without email" do
    user = User.new
    user.name = "Michael J. Fox"
    assert !user.save, "Saved user without email"
  end
  
  test "should not create user with email that already exists" do
    user = User.new
    user.name = "Tati Akamine"
    user.email = "tatiana.akamine@gmail.com"
    assert !user.save, "Created user with email that already exists"
  end
  
  # UPDATE
  test "should not update user without email" do
    user = users(:tati)
    user.email = nil
    user.name = "Michael J. Fox"
    assert !user.save, "Updated user with null email"
  end  

  test "should not update user with empty email" do
    user = users(:tati)
    user.email = ""
    user.name = "Michael J. Fox"
    assert !user.save, "Updated user with null email"
  end  
  
  test "should not update user with email that already exists" do
    user = users(:edna)
    user.email = "tatiana.akamine@gmail.com"
    assert !user.save, "Updated user with email that already exists"
  end
  
end
