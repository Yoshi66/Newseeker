class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:comment][:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def destroy
  end

  private

   def comment_params
        params.require(:comment).permit(:user_id, :article_id,:comment)
   end
end
