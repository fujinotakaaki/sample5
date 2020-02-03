class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
    arr = [('a'..'z'), ('A'..'Z'),('0'..'9')].map(&:to_a).flatten
    @about = (0..9).map{arr[rand(62)]}.join
  end

  def contact
    arr = [('a'..'z'), ('A'..'Z'),('0'..'9')].map(&:to_a).flatten
    @contact = (0..19).map{arr[rand(62)]}.join
  end
end
