class ArticlesController < ApplicationController
  
  def increment
    @article = Article.find(params[:id])
    @cont = params[:cont].to_i + 1
    redirect_to article_path(@article, cont: @cont)
  end
  
  def index
     @articles = Article.all
     render :index
  end

  def show
    @cont = params.fetch(:cont, 0).to_i
    @articles = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comments = Comment.where(article_id: params[:id])
    @comments.destroy_all
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  private 
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
