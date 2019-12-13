require 'sinatra'
require "sinatra/json"
require 'ox'
require 'pry'
get '/statuses/proteus' do
  xml = File.read(File.expand_path('proteus_report.xml', File.dirname(__FILE__)))
  res = Ox.load(xml, mode: :hash)
  data = [{
    name: "proteus",
    totalTests: res[:testsuite][0][:tests],
    totalErrors: res[:testsuite][0][:errors],
    totalFailures: res[:testsuite][0][:failures],
    totalSkips: res[:testsuite][0][:skips],
    rawData: res[:testsuite],
  }]
  json data
end
