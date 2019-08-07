class UsersController < ApplicationController

    get '/users/login' do 
        erb :'users/login'
    end 

    post '/users/login' do 
        @user = User.find_by(email: params[:email])
        if !@user.nil?
            erb :"posts/index"
        else
            redirect :'users/login'
        end 
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

    get '/logout' do 
        session.clear 
        redirect :'/'
    end 
end 
