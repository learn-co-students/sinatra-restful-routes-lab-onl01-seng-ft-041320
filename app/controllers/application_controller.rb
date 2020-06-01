class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes/new' do
    erb :'/recipes/new'
  end

  post '/recipes' do
    recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])

    erb :'/recipes/single'
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])

    erb :'/recipes/edit'
  end

  patch '/recipes/:id/edit' do
    recipe = Recipe.find(params[:id])
    recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    redirect "/recipes/#{params[:id]}"
  end

  get '/recipes' do
    @recipes = Recipe.all

    erb :'/recipes/all'
  end

  delete '/recipes/:id' do
    Recipe.destroy(params[:id])

    redirect '/recipes'
  end
end
