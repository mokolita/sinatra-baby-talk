class PostsController < ApplicationController

    get '/posts' do 
        @post = Post.all

        erb :'posts/index'
    end 

    get '/posts/new' do 
        authenticate
        erb :'posts/new'
    end 

    post '/posts' do 
        Post.create(title: cleaned_params[:title], content: cleaned_params[:content], user: current_user)
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
        @post = Post.find_by(id: cleaned_params[:id])
        return authorized?(@post)
        erb :'posts/edit'
    end 

    patch '/posts/:id' do
        @post = Post.find_by(id: cleaned_params[:id]) 
        authorized?(@post)
        @post.update(content: cleaned_params[:content])
        redirect '/posts'
    end 

end 