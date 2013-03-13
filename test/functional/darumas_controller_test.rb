# encoding: utf-8
require 'test_helper'

class DarumasControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
    assert_select 'h1', 'Dê um Daruma de presente  pra quem você gosta!'
    assert_select 'form input' do
      assert_select "[type=text]", 4
      assert_select "[id=daruma_new_sender_name]", 1
      assert_select "[id=daruma_new_sender_email]", 1
      assert_select "[id=daruma_new_user_email]", 1
      assert_select "[id=daruma_captcha]", 1
    end
    assert_select 'button', 'Enviar Daruma'
  end
  
  test "should create daruma with new user and sender" do
    post :create, daruma: { new_sender_email: "michaeljfox@michaeljfox.org", new_sender_name: "Michael J. Fox", new_user_email: "listas.tati@gmail.com", captcha: 4 }
    assert_response :success
    assert_select 'body', "Só mais uma coisinha: antes de enviar o Daruma, precisamos confirmar que você é você.Para fazer isso, basta entrar no seu e-mail (michaeljfox@michaeljfox.org) e seguir as instruções.\n\n\t\tEnviar mais um Daruma"
  end

  test "should create daruma with existing user and sender" do
    post :create, daruma: { new_sender_email: "michaeljfox@michaeljfox.org", new_sender_name: "Michael J. Fox", new_user_email: "listas.tati@gmail.com", captcha: 4 }
    assert_response :success
    assert_select 'body', "Só mais uma coisinha: antes de enviar o Daruma, precisamos confirmar que você é você.Para fazer isso, basta entrar no seu e-mail (michaeljfox@michaeljfox.org) e seguir as instruções.\n\n\t\tEnviar mais um Daruma"
  end

  test "should not create daruma with empty info" do
    #TODO this should verify an error message in the future
    post :create
    assert_response :success
    assert_select 'h1', 'Dê um Daruma de presente  pra quem você gosta!'
    assert_select 'form input' do
      assert_select "[type=text]", 4
      assert_select "[id=daruma_new_sender_name]", 1
      assert_select "[id=daruma_new_sender_email]", 1
      assert_select "[id=daruma_new_user_email]", 1
      assert_select "[id=daruma_captcha]", 1
    end
    assert_select 'button', 'Enviar Daruma'
  end
  
  test "should not create daruma with invalid captcha" do
    #TODO this should verify an error message in the future
    post :create, daruma: { new_sender_email: users(:tati).email, new_sender_name: users(:tati).name, new_user_email: users(:edna).email, captcha: 5 }
    assert_response :success
    assert_select 'h1', 'Dê um Daruma de presente  pra quem você gosta!'
    assert_select 'form input' do
      assert_select "[type=text]", 4
      assert_select "[id=daruma_new_sender_name]", 1
      assert_select "[id=daruma_new_sender_email]", 1
      assert_select "[id=daruma_new_user_email]", 1
      assert_select "[id=daruma_captcha]", 1
    end
    assert_select 'button', 'Enviar Daruma'
  end

  test "should confirm daruma" do
    get(:confirm, { 'id' => darumas(:left).id }, { 'token' => darumas(:left).token })
    assert_response :success
    #TODO assert_select conteúdo
  end

  test "should not confirm daruma with invalid token" do
    get(:confirm, { 'id' => darumas(:left).id }, { 'token' => 'invalidtoken' })
    assert_response :success
    #TODO assert conteudo
  end

end
