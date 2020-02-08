class AddIndexToUsersEmail < ActiveRecord::Migration[5.2]
  def change
    # 変更方法メソッド (:モデル名, :カラム名, オプション)
    # みたいな感じか
    add_index(:users, :email, :unique => true)
    # Biim兄貴「このまま($ rails db:migrate)しても、」
    # Biim兄貴「テストDB用のサンプルデータが含まれているfixtures内で一意性の制限が保たれていないため、」
    # Biim兄貴「($ rails test(:models))を実行しても、テストはREDとなります。」
    # 実行結果: => 9 tests, 0 assertions, 0 failures, 9 errors, 0 skips
    # Biim兄貴「だから、test/fixtures/users.ymlの全文をコメントアウトする必要があったんですね。」
  end
end
