class User < ApplicationRecord
  # 保存前にemail属性を小文字に変換してメールアドレスの一意性を保証する
  before_save { self.email = self.email.downcase }
  # before_save { self.email.downcase! } #こっちも可（同義）
  # ちなみに、左式ではself.を省略することはできません。

  # たぶんvarlidates関数の記述は下記のはず
  # def validates( :symbol, **changes )
  # def validates( :symbol, presense:false, uniq:true,.... )
  # :symbolが存在しないとエラーになる感じかな？
  # :presence => trueはString#blank?が聞いてると思われる
  validates( :name, :presence => true, :length => { :in => (1..50) } )
  # validates :name,  presence: true, length: { in: (1..50) }
  # format:{with:Regexp}で正規表現に従うもののみを通すことができるようになる。
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates( :email, :presence => true, :length => { :in => (3...256) },
  :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
  :uniqueness => { :case_sensitive => false } )
  # uniqueness:trueでは大文字小文字は区別される
  # 大文字と小文字の区別をなくす場合はuniqueness:true =>uniqueness: { case_sensitive: false }に置き換えることで実現できる（先輩優しいっすね）
  has_secure_password # ※モデル内にpassword_digestという属性を追加する必要あり
  # セキュアなパスワードの実装を可能にしてくれる超々々々便利なrails特有のメソッド（ウンチーコング兄貴風）
  # 次のような機能が使えるようになります！！！（他力本願）
  # 1. セキュアにハッシュ化したパスワードを、データベース内のpassword_digestという属性に保存できるようになる（なにそれ？）
  # 2. 2つのペアの仮想的な属性 (passwordとpassword_confirmation) が使えるようになる。
  # ↑存在性と値が一致するかどうかのバリデーションも実装済み↑
  # 3. authenticateメソッドが使えるようになる (引数の文字列がパスワードと一致するとUserオブジェクトを、間違っているとfalseを返すメソッド) 。
  validates( :password, :presence => true,  :length => { :minimum => 6 } ) # <= presenceって実装済みじゃないのか？？？
end
