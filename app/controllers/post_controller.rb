class PostsController < ApplicationController

    get '/posts' do
        authenticate 
        @post = Post.all
        erb :'posts/index'
    end 

    get '/posts/new' do 
            erb :'posts/new'
    end 

    post '/posts' do 
        @post = Post.create(title: params[:title], content: params[:content])
        redirect '/posts/:id'
    end 

    get '/post/:id' do 
        @post = Post.find(:id)
        "I am a post"
    end 

end 