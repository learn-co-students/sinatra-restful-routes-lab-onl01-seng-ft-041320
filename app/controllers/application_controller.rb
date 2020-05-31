require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
      redirect '/recipes'
    end

#Index
 get '/recipes' do
   @recipes = Recipe.all
   erb :index
 end

 #create
 post '/recipes' do
  Recipe.new(
    name: params[:name],
    ingredients: params[:ingredients],
    cook_time: params[:cook_time]
  ).tap do |recipe|
    recipe.save
    redirect "/recipes/#{recipe.id}"
  end
end

 #new
  get '/recipes/new' do
    erb :new
  end

  #Show
    get '/recipes/:id' do
      @recipe = Recipe.find_by(params[:id])
      erb :show
    end

#Edit
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(params[:id])
    erb :edit
  end

#Update
patch '/recipes/:id' do
  Recipe.find(params[:id]).tap do |recipe|
    recipe.update(
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time]
    )

    redirect to "/recipes/#{recipe.id}"

  end
  end

#Destroy
  delete '/recipes/:id' do
    Recipe.find(params[:id]).destroy
    redirect to "/recipes"
  end



end
