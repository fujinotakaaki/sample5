require 'test_helper'
# $ rails test で下２つが実行される、ことまでわかってる（逃げ）
# test/controllers/static_pages_controller_test.rb
# test/integration/site_layput_test.rb <= $ rails test:integrationではこっちだけ実行
class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "Check layout links at root page. (Home page)" do
    get root_path
    # 「/」入れない、デフォルトで入るし
    assert_template 'static_pages/home'

    # evalを使ったassert_selectの実行
    # name配列の作成
    name_arr = %w(root help about contact)
    # 各path存在数の配列
    count_arr = %w(3 2 2 2).map(&:to_i)
    #どう考えても、[3, 2, 2, 2]のほうが楽で見栄えもいい、、、

    # [name, count]の羅列に変換してeach発動
    arr = Array.new(name_arr.size, nil).zip(name_arr, count_arr).map(&:compact)
    # arr = [name_arr, count_arr].transpose
    # 上２つ↑はどっちも[["root", 3], ["help", 2], ["about", 2], ["contact", 2]]
    arr.each do | name, idx | # 4回実行
      # assert_select "a[href=?]", root_path, count: 3 # これは成功する
      # eval( %(assert_select \"a[href=?]\", root_path, count: 3 )) # これも成功する
      # eval( %( assert_select \"a[href=?]\", #{name}_path, count: #{idx} )) # OK!!!
      eval( %( assert_select %q(a[href=?]), #{name}_path, count: #{idx} )) # これもOK!!!
      # eval( %q( assert_select %q(a[href=?]), #{name}_path, count: #{idx} )) # これは流石にNG

      # ↓元のコード↓
      # assert_select "a[href=?]", root_path, count: 3
      # assert_select "a[href=?]", help_path, count: 2
      # assert_select "a[href=?]", about_path, count: 2
      # assert_select "a[href=?]", contact_path, count: 2
    end
  end

  test "Check title at Contact page." do
    get contact_path
    assert_select %(title), full_title(%(Contact))
  end

  test "Check title at Sign up page." do
    get signup_path
    assert_select %(title), full_title(%(Sign up))
  end
end
