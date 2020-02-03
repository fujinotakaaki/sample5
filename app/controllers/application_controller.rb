class ApplicationController < ActionController::Base

  def hello
    arr = [('a'..'z'), ('A'..'Z'),('0'..'9')].map(&:to_a).flatten
    render html:"Hello World!! " + (0..9).map{arr[rand(62)]}.join
  end
end
