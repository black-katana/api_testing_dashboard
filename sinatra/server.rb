require 'sinatra'
require "sinatra/json"
require 'ox'

get '/statuses/proteus' do
  xml = File.read(File.expand_path('proteus_report.xml', File.dirname(__FILE__)))
  res = Ox.load(xml, mode: :hash)
  json res
end
