require 'test_helper'

class RoutesTest < ActionController::IntegrationTest
  test "/ should route to darumas#new" do
    assert_recognizes({ :controller => "darumas", :action => "new" }, "/")
  end

end