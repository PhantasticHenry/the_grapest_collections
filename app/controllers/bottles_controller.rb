class BottlesController < ApplicationController

  # GET: /bottles
  get "/bottles" do
    erb :"/bottles/index.html"
  end

  # GET: /bottles/new
  get "/bottles/new" do
    erb :"/bottles/new.html"
  end

  # POST: /bottles
  post "/bottles" do
    if params.empty?
      redirect "/bottles/new"
    end
    bottle = Bottle.new(wine_type: params[:wine_type], vintage: params[:vintage], price: params[:price])
    bottle.user_id = current_user.id
    bottle.save
    redirect "/bottles/#{bottle.id}"
  end

  # GET: /bottles/5
  get "/bottles/:id" do
    @bottle = Bottle.find(params[:id])
    erb :"/bottles/show.html"
  end

  # GET: /bottles/5/edit
  get "/bottles/:id/edit" do
    erb :"/bottles/edit.html"
  end

  # PATCH: /bottles/5
  patch "/bottles/:id" do
    redirect "/bottles/:id"
  end

  # DELETE: /bottles/5/delete
  delete "/bottles/:id/delete" do
    redirect "/bottles"
  end
end
