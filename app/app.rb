require 'sinatra/base'
require 'sinatra/json'
require 'json'
require_relative '../data_mapper_setup'

class Chan < Sinatra::Base
  use Rack::MethodOverride

  set :static, true
  set :root, File.dirname(__FILE__)

  get '/' do
    erb :index
  end

  get '/json' do
    content_type :json
    post = Post.all
    boss = post.to_json
  end

  post '/json' do
    post = request.body.read
    submission = Post.new(JSON.parse(post))
    if submission.save
      status 201
    else
      status 500
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
