class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
#show INDEX of recipes
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end
#load NEW recipe form
  get '/recipes/new' do
    erb :new
  end
#CREATE new recipe
  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end
#SHOW single recipe
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])

    erb :show
  end
#load EDIT recipe form
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end
#UPDATE a recipe
  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.update(name: @recipe.name, ingredents: @recipe.ingredients, cook_time: @recipe.cook_time)

    redirect "/recipes/#{@recipe.id}"
  end
#DELETE a recipe
  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete

    redirect "/recipes"
  end
end
