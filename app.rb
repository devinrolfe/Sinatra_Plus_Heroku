# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

require 'sinatra/flash'
require 'sinatra/redirect_with_flash'

enable :sessions

class Post < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
end



get '/' do
  @posts = Post.order("created_at DESC")
  @title = "Welcome."
  erb :"posts/index"
end

helpers do
  def title
    if @title
      "#{@title}"
    else
      "Welcome."
    end
  end
end

get "/posts/create" do
  @title = "Create post"
  @post = Post.new
  erb :"posts/create"
end

get '/posts/:id' do
  @post = Post.find params[:id]
  @title = @post.title
  erb :"posts/view"
end

post "/posts" do
  @post = Post.new(params[:post])
  if @post.save
    redirect "posts/#{@post.id}", :notice => 'Congrats! Love the new post. (This will disappear in 4 seconds)'
  else
    redirect "posts/create", :error => 'Something went wrong. Try again. (This will disappear in 4 seconds)'
  end
end

# edit post
get "/posts/:id/edit" do
  @post = Post.find(params[:id])
  @title = "Edit Form"
  erb :"posts/edit"
end

put "/posts/:id" do
  @post = Post.find(params[:id])
  @post.update(params[:post])
  redirect "/posts/#{@post.id}"
end