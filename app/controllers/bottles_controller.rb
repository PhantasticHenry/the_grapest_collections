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
    if params.empty?
      redirect "/bottles/new"
    end
    bottle = Bottle.new(name: params[:name], grape: params[:grape], style: params[:style], vintage: params[:vintage], price: params[:price])
    bottle.user_id = current_user.id
    bottle.save
    redirect "/bottles/#{bottle.id}"
  end

  get "/bottles/:id" do
    find_and_set
    erb :"/bottles/show.html"
  end
  
  patch "/bottles/:id" do
    find_and_set
    if !@bottle.user == current_user
      redirect "/users/#{current_user.id}"
    else
      @bottle.update(params[:bottle])
      redirect "/bottles/#{bottle.id}"
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
