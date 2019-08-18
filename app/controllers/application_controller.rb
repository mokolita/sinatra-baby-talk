class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    enable :sessions 
    set :session_secret, SESSION_SECRET
    set :views, Proc.new { File.join(root, "../views/") }
    set :public_folder, "public"

    get '/' do 
        erb :'index'
    end 

    get '/home' do 
        @user = current_user
        erb :'home'
    end 

    helpers do 

        def logged_in?
            !!session[:id]
        end 

        def current_user 
           User.find_by(id: session[:id]) 
        end 

        def login(cleaned_params)
            @user = User.find_by(email: cleaned_params[:email])
            if @user && @user.authenticate(cleaned_params[:password])
                session[:id] = @user.id
                erb :'home'
            else 
                @failed = true
                erb :'users/login'
            end 
        end 

        def logout!
            session.clear
        end 

        def authenticate 
            if !logged_in?
                redirect '/users/login'
            end 
        end 

        def authorized?(post)
            authenticate
             if !post
                return erb :'error'
             end
            if current_user != post.user
                return erb :'error'
            end
        end 

        def cleaned_params(params)
            cleaned_params = {}
            params.each{ |k,v| cleaned_params[k]  = Rack::Utils.escape_html(v) }
        end 

        not_found do
            status 404
            erb :'not_found' 
        end 
          
    end 

end 