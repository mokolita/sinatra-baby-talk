require './config/environment'


use Rack::MethodOverride
use UsersController
use PostsController
run ApplicationController