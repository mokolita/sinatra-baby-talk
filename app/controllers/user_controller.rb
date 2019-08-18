class UsersController < ApplicationController

    get '/users/login' do 
        @failed = false
        erb :'users/login'
    end 

    post '/users/login' do
        login(params)
    end 
    
    get '/users/signup' do 
        erb :'users/signup'
    end 

    post '/users' do 
            @user = User.create(name: params[:name], email: params[:email], password: params[:password])
            if @user.save
                login(params)
            else 
                erb :'users/signup'
            end 
        end  

    delete '/logout' do 
        session.clear 
        redirect :'/'
    end 

    get '/users/:id/posts' do
        @user = User.find_by(id: params[:id])
        erb :'users/posts'
    end 
end 
