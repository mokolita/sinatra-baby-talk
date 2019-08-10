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

    post '/users/signup' do 
            @user = User.create(email: params[:email], password: params[:password])
            if @user.save
                redirect 'users/login'
            else 
                erb :'users/signup'
            end 
        end  

    delete '/logout' do 
        session.clear 
        redirect :'/'
    end 
end 
