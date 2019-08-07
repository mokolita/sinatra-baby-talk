class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    set :session_secret, SESSION_SECRET
    set :views, Proc.new { File.join(root, "../views/") }

    get '/' do 
        erb :'index'
    end 

    helpers do 

        def logged_in?
            !!current_user
        end 

        def current_user 
            @current_user ||= User.find_by(:email => session[:email]) if session[:email]
        end 

        def login(email, password)
            user = User.find_by(:email => email)
            if user && user.authenticate(password)
                session[:email] = user.email
            else 
                redirect 'users/login'
            end 
        end 

        def logout!
            session.clear
        end 
    end 

end 