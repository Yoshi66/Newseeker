class HomeController < ApplicationController
  def welcome
    @articles = Article.all
  end
end
