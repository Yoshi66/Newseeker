class HomeController < ApplicationController
  def welcome
    @articles = Article.all
    @top_article = Article.all.first
    @second_article = Article.all.find_by(id: 2)
    @third_article = Article.all.find_by(id: 3)
    @one_articles = Article.all
    if signed_in?
      @article_feed = current_user.feed
      puts @article_feed
    else
      @article_feed = Article.all.order('articles.created_at DESC')
    end
  end
end
