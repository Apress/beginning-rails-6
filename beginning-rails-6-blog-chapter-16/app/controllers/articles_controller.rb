class ArticlesController < ApplicationController
  before_action :authenticate, except: [:index, :show, :notify_friend]
  before_action :set_article, only: [:show, :notify_friend]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.includes(:user).with_rich_text_body.with_attached_cover_image.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @email_a_friend = EmailAFriend.new
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = current_user.articles.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article = current_user.articles.find(params[:id])
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
    @article = current_user.articles.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def notify_friend
    @email_a_friend = EmailAFriend.new(email_a_friend_params)

    if @email_a_friend.valid?
      NotifierMailer.email_friend(@article, @email_a_friend.name, @email_a_friend.email).deliver_later
      redirect_to @article, notice: 'Successfully sent a message to your friend'
    else
      render :notify_friend, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :cover_image, :remove_cover_image, :location, :excerpt, :body, :published_at, category_ids: [])
    end

    def email_a_friend_params
      params.require(:email_a_friend).permit(:name, :email)
    end
end
