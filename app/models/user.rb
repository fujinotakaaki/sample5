class User < ApplicationRecord
  # たぶんvarlidates関数の記述は下記のはず
  # def validates( :symbol, **changes )
  # def validates( :symbol, presense:false, uniq:true,.... )
  # :symbolが存在しないとエラーになる感じかな？
  # :presence => trueはString#blank?が聞いてると思われる
  validates(:name, :presence => true, :length => { :in => (1..50) } )
  # validates :name,  presence: true, length: { in: (1..50) }
  # format:{with:Regexp}で正規表現に従うもののみを通すことができるようになる。
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, :presence => true, :length => { :in => (3...256) }, :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, :uniqueness => { :case_sensitive => false } )
  # uniqueness:trueでは大文字小文字は区別される
  # 大文字と小文字の区別をなくす場合はuniqueness:true =>uniqueness: { case_sensitive: false }に置き換えることで実現できる（先輩優しいっすね）
end
