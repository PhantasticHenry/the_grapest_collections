class BottlesController < ApplicationController

  get "/bottles" do
    @bottles = Bottle.all
    @sorted_bottles = @bottles.order(name: :asc).uniq
    erb :"/bottles/index.html"
  end

  get "/bottles/new" do
    if !logged_in?
      flash[:error] = "Please Login To Add Bottle"
      redirect "/users/login"
    end
    erb :"/bottles/new.html"
  end

  post "/bottles" do
    @bottle = current_user.bottles.build(name: params[:name], grape: params[:grape], style: params[:style], vintage: params[:vintage], price: params[:price])
    if @bottle.save
      redirect "/bottles/#{@bottle.id}"
    else
      @bottle.errors.full_messages.each do |message|
        flash[:error] = "#{message}"
        redirect "/bottles/new"
      end
    end
  end

  get "/bottles/:id" do
    find_and_set
    if @bottle 
      erb :"/bottles/show.html"
    else
      flash[:error] = "Bottle Does Not Exist"
      redirect "/bottles"
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
      flash[:error] = "You may not edit this bottle."
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
      @bottle = Bottle.find_by(id: params[:id])
    end
end
