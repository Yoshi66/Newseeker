class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new]
  before_action :set_article_feed

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    if signed_in?
      @article_feed = current_user.feed
      puts @article_feed
    else
      @article_feed = Article.all
    end
    @articles = Article.all
    @comment = Comment.new
  end

  # GET /articles/new
  def new
    @article = Article.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    p "CCCCCCCCCCCCCCCCC"
    puts params
    if params[:article][:url].starts_with?("http")
      p "BBBBBBBBBBBBBBBBBBBBBBB"
      @article = current_user.articles.build(article_params)
      p "DDDDDDDDDD"
      respond_to do |format|
        if @article.save
          format.html { redirect_to root_path, notice: 'Article was successfully created.' }
          format.json { render :show, status: :created, location: @article }
        else
          puts @article.errors.full_messages
          puts @article.photo.url
          # puts @article.photo.url.slice(0..(@article.photo.url.index('?')))[0..-2]
          format.html { render :new }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search_result
    puts params
    if params[:search]
      puts 'AAAAA'
      @articles = Article.search(params[:search]).order("created_at DESC")
      respond_to do |format|
        format.js {render "alert('Hello Rails');"}
        format.html
        puts 'CCCCC'

      end
    else
      puts 'BBBB'
      @articles = Article.order("created_at DESC")
    end
  end

  # def list_results
  #   puts 'DDDDDDDDDDDDDDD'
  #   puts params
  #   @articles = @q.result(distinct: true)
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def set_article_feed
      @article_feed = Article.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :url,:photo)
    end
end
