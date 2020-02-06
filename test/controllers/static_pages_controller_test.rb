require 'test_helper'
# $ rails test で下２つが実行される、ことまでわかってる（逃げ）
# test/controllers/static_pages_controller_test.rb
# test/integration/site_layput_test.rb <= $ rails test:integrationではこっちだけ実行
class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  test %(full title helper) do
      assert_equal full_title(''), @base_title
      assert_equal full_title(%q(Help)), %Q(Help | #{@base_title})
  end

  # test "should get root (home)" do
  #   # get static_pages_home_url
  #   get root_path
  #   assert_response :success
  #   assert_select "title", "Home | #{@base_title}"
  # end

  test "should get help" do
    # get static_pages_help_url
    get help_path
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    # get static_pages_about_url
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    # get static_pages_contact_url
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

end
