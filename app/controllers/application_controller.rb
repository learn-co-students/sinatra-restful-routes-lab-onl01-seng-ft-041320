class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

#index
  get '/recipes' do
    @recipes= Recipe.all
    erb :index
  end

#new
get '/recipes/new' do #loads new form
  erb :new
end

#create
post '/recipes' do  #creates a recipe
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

#edit
 get '/recipes/:id/edit' do
   id= params[:id]
   @recipe= Recipe.find_by(id: id)
   erb :edit
 end

#update
patch '/recipes/:id' do
   recipe = Recipe.find_by(id: params[:id])
   recipe.update(params[:recipe])
   redirect to "/recipes/#{recipe.id}"
 end

#destroy
delete '/recipes/:id' do
    id = params[:id]
    @recipe = Recipe.find_by(id: id)
    @recipe.delete
end



#show
  get '/recipes/:id' do
    id= params[:id]
    @recipe= Recipe.find_by(id: id)
    erb :show
  end

end
