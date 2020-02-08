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
    # 無効なメールアドレスはちゃんと振り落とされるか検証
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
    # ここら辺（重複関係）のテストでエラーになるなら、db/migrate/(date)_index_to_add_...#!/usr/bin/env ruby -wKU
    # changeメソッドのadd_index実装してないのか？
    # それとも、test/fixtures/users.ymlの全文をコメントアウトしてないとか？
  end

  test "email addresses should be saved as lower-case" do
    # app/models/user.rbでbefore_save { self.email = email.downcase }を実装しているため、
    # 元の入力と登録されているメールアドレスは異なる。（大文字が１個もないなら話は別）
    mixed_case_email = "FooBAr@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
    # assert_equal mixed_case_email.downcase, @user.email
    # before_save { self.email.downcase! }にすると、↑のように#reload必要なしにできるらしい
    # ちなみに、これにしなくてもテスト通っちゃったんですがそれは...（困惑）
    # じゃけん、reloadメソッド使う方にしましょうね
    # ------解説-----------------------------------------------------------------------------------------
    # Biim兄貴「最後コードは、元のemailアドレス（左辺）とDB上のemailアドレスが一致しているか比較しています。」
    # Biim兄貴「メモリ（ここでは@userに限定）に保存されているものとDBに保存されているデータは」
    # Biim兄貴「"常に"一致しているとは限りません（なんで？（殺意））」
    # Biim兄貴「だから、リロード（リフレッシュ・最新の状態に）してやる必要があったんですね。」

    # Biim兄貴「まあ、@userはDBの中身を参照しているわけじゃないし（多分メモリを参照している）、」
    # Biim兄貴「DBと@userの中身が違っちゃうのは仕方ないね♂」
    # -----------------------------------------------------------------------------------------------------
    # ~~~reloadメソッドについて~~~
    # app配下(あたり)にあるソースコードを読み直します。（ざっくり）
    # ↓多分こんな感じらしい↓
    # $ rails console --sandbox
    # @sample = Sample.find(1) # @sample.name => 'Tadokoro'
    # Sample.find(1).update_column(:name, 'Yajue')
    # @sample.name # =>  # @sample.name => 'Tadokoro'
    # @sample.reload.name => # @sample.name => 'Yajue'
    # reference: https://teratail.com/questions/2230
    # -----------------------------------------------------------------------------------------------------
  end
end # class UserTest < ActiveSupport::TestCase
