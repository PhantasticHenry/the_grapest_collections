class BottlesController < ApplicationController

  # GET: /bottles
  get "/bottles" do
    @bottles = Bottles.all 
    erb :"/bottles/index.html"
  end

  # GET: /bottles/new
  get "/bottles/new" do
    if !logged_in? 
      redirect "/login"
    end
    erb :"/bottles/new.html"
  end

  # POST: /bottles
  post "/bottles" do
    if params.empty?
      redirect "/bottles/new"
    end
    bottle = Bottle.new(name: params[:name], grape: params[:grape], style: params[:style], vintage: params[:vintage], price: params[:price])
    bottle.user_id = current_user.id
    bottle.save
    redirect "/bottles/#{bottle.id}"
  end

  get "/bottles/:id" do
    @bottle = Bottle.find(params[:id])
    erb :"/bottles/show.html"
  end
  
  patch "/bottles/:id" do
    @bottle = Bottle.find(params[:id])
    if !@bottle.user == current_user
      redirect "/users/#{current_user.id}"
    else
      @bottle.update(params[:bottle])
      redirect "/bottles/#{@bottle.id}"
    end
  end

  delete "/bottles/:id/delete" do
    @bottle = Bottle.find(params[:id])
    if @bottle.user == current_user
      @bottle.destroy
      redirect "/users/#{current_user.id}"
    else
      redirect "/bottles/#{@bottle.id}"
    end
  end
end
