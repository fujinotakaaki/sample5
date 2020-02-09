require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      # この登録内容でいけるかのチェック
      post users_path, :params => { :user => { :name =>  '', :email => "user@invalid", :password => "foo", :password_confirmation => "bar" } }
      # 下記コード等価らしい（DB登録の前後でテーブルの行が増えてるか見ているよう）　
      # before_count = User.count
      # post users_path, ...
      # after_count  = User.count
      # assert_equal before_count, after_count
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select 'form[action="/signup"]'
    # views/users/new.html.erb
    # form_for(@user)だとurlが*/usersになっちゃう
    # form_for(@user, url: signup_path)とすることで、正しいurlにしてやり、
    # その確認のテスト
  end

  test "valid signup information" do
   get signup_path
   assert_template 'users/new'
   assert_difference 'User.count', 1 do
     post users_path, :params => { :user => { :name =>  'Hatsune_Miku', :email => "vocaloid@utau.com",
       :password => "fujitasaki", :password_confirmation => "fujitasaki" } }
   end
   follow_redirect!
   # POSTリクエストを送信した結果を見て、指定されたリダイレクト先に移動するメソッドです。
   assert_template 'users/show'
   assert_not flash.empty?
 end
end
