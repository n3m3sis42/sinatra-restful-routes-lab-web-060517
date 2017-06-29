class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do
    erb :index
  end

  get '/recipes' do
    erb :'/recipes/index'
  end

  get '/recipes/new' do
    erb :'recipes/new'
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :'/recipes/show'
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :'/recipes/edit'
  end

  patch '/recipes/:id' do
    binding.pry
    @recipe = Recipe.find(params[:id])
    if @recipe.update(params[:recipe])
      redirect "/recipes/#{@recipe.id}"
    else
      redirect "/recipes/#{@recipe.id}/edit"
    end
  end

  post '/recipes' do
    @recipe = Recipe.new(params[:recipe])
    if @recipe.save
      redirect "/recipes/#{@recipe.id}"
    else
      redirect '/recipes/new'
    end
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect '/recipes'
  end

end
