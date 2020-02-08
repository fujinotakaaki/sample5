require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new( name: 'Example_user', email: 'example_user@example.com' )
  end

  test "should be valid" do
    # setupした@userは使えるか？
    assert @user.valid?
  end

  test 'name must be present' do
    # 空白文字のみで構成されたものは使えるか？
    @user.name = '     '
    assert_not @user.valid?
  end

  test "name should not be too long" do
    # 文字制限を超えるものはNGとなるか？
    @user.name = ?a * 51
    assert_not @user.valid?
  end

  test "email should be present" do
    # 空白文字のみで構成されたものは使えるか？
    @user.email = "     "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    # 文字制限を超えるものはNGとなるか？
    @user.email = "#{?a*244}@example.com"
    assert_not @user.valid?
  end

  test "name and email should not be too long" do
    # nameもemailも文字制限を超えるものはNGとなるか？
    @user.name = 'RIP' + 'ruby' * 12
    @user.email = %(#{'ruby' * 61}@example.com)
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    # 有効なメールアドレスはちゃんと通るのか検証
    valid_addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn)
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    # 向こうなメールアドレスはちゃんと振り落とされるか検証
    invalid_addresses = %w(user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com )
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    # メールアドレスの重複は弾かれるか検証
    duplicate_user = User.new( name:@user.name, email:@user.email.upcase )
    @user.save
    assert_not duplicate_user.valid?
  end
end # class UserTest < ActiveSupport::TestCase
