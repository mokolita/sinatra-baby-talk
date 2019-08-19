class PostsController < ApplicationController

    get '/posts' do 
        authenticate 
        @post = Post.all
        erb :'posts/index'
    end 

    get '/posts/new' do 
        authenticate
        erb :'posts/new'
    end 

    post '/posts' do 
        authenticate
        cleaned_params(params)
        Post.create(title: @@safe_params[:title], content: @@safe_params[:content], user: current_user)
        
        redirect '/posts'
    end 

    get '/posts/:id' do 
        @post = Post.find_by(id: params[:id]) || halt(404)
        authenticate
        erb :'posts/show'
    end 

    delete '/posts/:id' do 
        @post = Post.find_by(id: params[:id])
        authorized?(@post)
        if @post
            @post.destroy
            redirect '/posts'
        end 
    end
    
    get '/posts/:id/edit' do 
        @post = Post.find_by(id: params[:id])
        authorized?(@post)
        erb :'posts/edit'
       
    end 

    patch '/posts/:id' do
        cleaned_params(params)
        #binding.pry
        @post = Post.find(params[:id]) 
        authorized?(@post)
        @post.update(title: @@safe_params[:title], content: @@safe_params[:content])
        redirect '/posts'
    end 

end 