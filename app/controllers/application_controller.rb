class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    enable :sessions 
    set :session_secret, SESSION_SECRET
    set :views, Proc.new { File.join(root, "../views/") }

    get '/' do 
        erb :'index'
    end 

    helpers do 

        def logged_in?
            !!session[:id]
        end 

        def current_user 
           User.find_by(id: session[:id]) 
        end 

        def login(params)
            
            user = User.find_by(:email => params[:email])
            if user && user.authenticate(params[:password])
                session[:id] = user.id
                redirect '/posts'
            else 
                @failed = true
                redirect '/users/login'
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
    end 

end 