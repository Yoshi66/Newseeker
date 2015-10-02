class HomeController < ApplicationController
  def welcome
    @articles = Article.all
    @top_article = Article.all.first
    @second_article = Article.all.find_by(id: 2)
    @third_article = Article.all.find_by(id: 3)
    @one_articles = Article.all
    if signed_in?
      # @articles = current_user.feed
      puts @articles
      puts "AAAAAAAAAAAAAAA"
      puts "AAAAAAAAAAAAAAA"
      puts "AAAAAAAAAAAAAAA"
    else
      @articles = Article.all
      puts "BBBBBBBBBBBBBB"
      puts "BBBBBBBBBBBBBB"
      puts "BBBBBBBBBBBBBB"
    end
  end
end
