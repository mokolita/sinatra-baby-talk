class PostsController < ApplicationController

    get '/posts' do 
        "List of all the Locations"
    end 

    get '/locations/new' do 
        if !logged_in?
            redirect "/login"
        else 
            "A new location form"
        end
    end 

    get '/locations/:id/edit' do 
        if !logged_in?
            redirect '/login'
        else 
           if  location = current_user.locations.find(params[:id])
                "An edit locaation form #{current_user.id} is editing #{location.id}."
           else 
            redirect '/locations'
           end 
        end 
    end 
end 