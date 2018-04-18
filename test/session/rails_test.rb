require 'test_helper'

class Session::Rails::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Session::Rails
  end
end
