
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end 
  get '/articles/new' do 
    erb :new
  end 
  post '/articles' do 
    
    @article = Article.create(params)
    id = @article.id
    
    redirect "/articles/#{id}"
  end 
  get '/articles' do 
    @all = Article.all
    erb :index
  end 
  get '/articles/:id' do 
    
    @article = Article.find_by(params)
    erb :show
  end  
  get '/articles/:id/edit' do 
    @article = Article.find(params["id"])
    erb :edit
  end
  patch '/articles/:id' do 
    
    id = params["id"]
    new_params = {}
    old_article = Article.find(id)
    new_params[:title] = params["title"]
    new_params[:content] = params["content"]
    @article = Article.find(params["id"])
    old_article.update(new_params)
    redirect "/articles/#{id}"
  end 
  post "/articles/:id/delete" do 
    
    Article.find(params[:id]).destroy
    redirect '/index'
  end  
end
