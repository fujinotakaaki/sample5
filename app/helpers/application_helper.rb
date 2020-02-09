
# ここは全ページ（views）共通で使えるモジュール
module ApplicationHelper
  #重複ありの大文字小文字英数字の文字列を返す
  def random_characters( length = 0 )
    arr = [('a'..'z'), ('A'..'Z'),('0'..'9')].map(&:to_a).flatten
    (0...length).map{arr[rand(62)]}.join
  end
  # ページごとの完全なタイトルを返します。                   # コメント行
  def full_title(page_title = '')                     # メソッド定義とオプション引数
    base_title = "Ruby on Rails Tutorial Sample App"  # 変数への代入
    if page_title.empty?                              # 論理値テスト
      base_title                                      # 暗黙の戻り値
    else
      page_title + " | " + base_title                 # 文字列の結合
    end
  end
end
