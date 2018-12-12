
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    Rack::MethodOverride
  end

  get '/' do
  end

  # new - just form, not submitting
  get '/articles/new' do
    erb :new
  end

  # index
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  # show
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  # create
  post '/articles' do
    @article = Article.create(params)
    redirect "/articles/#{@article.id}"
  end

  # edit --- edit form
  get '/articles/:id/edit' do
    # model?
    @article = Article.find(params[:id])
    # resp?
    erb :edit
  end

  # update
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.update(title: params[:title], content: params[:content])
    @article.save
    erb :show
  end

  delete '/articles/:id' do
    @article = Article.find(params[:id])
    @article.destroy
    redirect "/articles"
  end


end
