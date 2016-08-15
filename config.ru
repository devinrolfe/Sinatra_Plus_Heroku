# config.ru

#require './app'
#run Sinatra::Application


$:.unshift File.expand_path("../", __FILE__)
require 'rubygems'
require 'sinatra'
require './web'
run Sinatra::Application