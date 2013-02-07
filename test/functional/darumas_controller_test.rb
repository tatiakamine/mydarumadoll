require 'test_helper'

class DarumasControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
    assert_select 'h1', 'Envie um Daruma em apenas um clique:'
    assert_select 'form input' do
      assert_select "[type=text]", 3
      assert_select "[type=submit]", 1
      assert_select "[id=daruma_new_sender_name]", 1
      assert_select "[id=daruma_new_sender_email]", 1
      assert_select "[id=daruma_new_user_email]", 1
    end
  end
  
  test "should create daruma" do
    post :create, daruma: { new_sender_email: users(:tati).email, new_sender_name: users(:tati).name, new_user_email: users(:edna).email }
    assert_response :success
    assert_select 'body', 'SENT!'
  end

  test "should not create daruma with empty info" do
    #TODO this should verify an error message in the future
    post :create
    assert_response :success
    assert_select 'h1', 'Envie um Daruma em apenas um clique:'
    assert_select 'form input' do
      assert_select "[type=text]", 3
      assert_select "[type=submit]", 1
      assert_select "[id=daruma_new_sender_name]", 1
      assert_select "[id=daruma_new_sender_email]", 1
      assert_select "[id=daruma_new_user_email]", 1
    end
  end

end
