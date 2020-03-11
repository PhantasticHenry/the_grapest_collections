class BottlesController < ApplicationController

  get "/bottles" do
    @bottles = Bottle.all 
    erb :"/bottles/index.html"
  end

  get "/bottles/new" do
    if !logged_in? 
      redirect "/"
    end
    erb :"/bottles/new.html"
  end

  post "/bottles" do
    if params[:name].empty? || params[:grape].empty? || params[:style].empty? || params[:vintage].empty? || params[:price].empty?
      flash[:error] = "Please fill in all fields."
      redirect "/bottles/new"
    end
    bottle = Bottle.new(name: params[:name], grape: params[:grape], style: params[:style], vintage: params[:vintage], price: params[:price])
    bottle.user_id = current_user.id
    bottle.save
    redirect "/bottles/#{bottle.id}"
  end

  get "/bottles/:id" do
    find_and_set
    if @bottle
      erb :"/bottles/show.html"
    else
      redirect "/"
    end
  end

  # get "/bottles/:id/edit" do 
  #   if !logged_in? 
  #     redirect "/"
  #   end
  #   find_and_set
  #   erb :"/bottles/edit.html"
  # end
  
  patch "/bottles/:id" do
    find_and_set
    if !@bottle.user == current_user
      redirect "/users/#{current_user.id}"
    else
      @bottle.update(params[:bottle])
      redirect "/bottles/#{@bottle.id}"
    end
  end

  delete "/bottles/:id/delete" do
    find_and_set
    if @bottle.user == current_user
      @bottle.destroy
      redirect "/users/#{current_user.id}"
    else
      redirect "/bottles/#{bottle.id}"
    end
  end

  private

    def find_and_set
      @bottle = Bottle.find(params[:id])
    end
end
