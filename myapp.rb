#!/usr/bin/env ruby

# myapp.rb
require 'sinatra'
require "base64"
require 'net/http'
require 'uri'
require 'json'





post "/api" do
    request.body.rewind  # in case someone already read it
    data = JSON.parse request.body.read
    # return "Hello #{data['value']}!"

    uri = URI.parse("http://172.16.3.142:4000")

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


    post_uri = URI.parse("http://172.16.2.151/api/image")


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
