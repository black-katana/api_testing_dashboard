require 'sinatra'
require 'sinatra/json'
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

get '/statuses' do
  data = []
  Dir.glob("../reports/*").each do |path|
    xml = File.read(path)
    res = Ox.load(xml, mode: :hash)
    data << {
      name: File.basename(path),
      totalTests: res[:testsuite][0][:tests],
      totalErrors: res[:testsuite][0][:errors],
      totalFailures: res[:testsuite][0][:failures],
      totalSkips: res[:testsuite][0][:skips],
      rawData: res[:testsuite],
    }
  end
  json(data)
end

get '/reports' do
  files = Dir.glob("../reports/*").map { |f| File.basename(f) }

  json(reports: files)
end
