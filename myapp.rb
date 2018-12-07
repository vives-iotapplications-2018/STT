#!/usr/bin/env ruby

# myapp.rb
require 'sinatra'
require "base64"
require 'net/http'
require 'uri'
require 'json'
require 'dotenv/load'


#http://localhost:4567/api

post "/api" do
    request.body.rewind  # in case someone already read it
    data = JSON.parse request.body.read
    # return "Hello #{data['value']}!"

    uri = URI.parse(ENV["HTTP_CONVERTER_HTTP"] + "://" + ENV["HTTP_CONVERTER_HOST"] + ":" + ENV["HTTP_CONVERTER_PORT"] +  ENV["HTTP_CONVERTER_PATH"])

    header = {'Content-Type': 'application/json'}
    body = {
        "id": 1,
        "value": data['value'],
        "unit": "C"
        }

    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = body.to_json.to_s

    # Send the request
    response = http.request(request)
    picture = response.body
    puts response.body


    post_uri = URI.parse(ENV["HTTP_TV_HTTP"] + "://" + ENV["HTTP_TV_HOST"] + ":" + ENV["HTTP_TV_PORT"] +  ENV["HTTP_TV_PATH"])


    header = {'Content-Type': 'application/x-www-form-urlencoded'}
    user = {'image': picture }
    
    # Create the HTTP objects
    http = Net::HTTP.new(post_uri.host, post_uri.port)
    request = Net::HTTP::Post.new(post_uri.request_uri, header)
    request.set_form_data(user)
    puts "created HTTP Objects"
    
    # Send the request
    response = http.request(request)
    print "inspection of request: " ,request.inspect
    

    return "ok"
  end
