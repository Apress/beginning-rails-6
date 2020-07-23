class CommentsController < ApplicationController
  before_action :load_article, except: :destroy
  before_action :authenticate, only: :destroy

  def create
    @comment = @article.comments.new(comment_params)
    if @comment.save
      redirect_to @article, notice: 'Thanks for your comment'
    else
      redirect_to @article, alert: 'Unable to add comment'
    end
  end

  def destroy
    @article = current_user.articles.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to @article, notice: 'Comment deleted'
  end

  private

  def load_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:name, :email, :body)
  end
end
