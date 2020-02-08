class AddPasswordDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_digest, :string
    # has_secure_passwordを使ってパスワードをハッシュ化するためには、
    # 最先端のハッシュ関数であるbcryptが必要になります。（あ、ふーん）
  end
end
