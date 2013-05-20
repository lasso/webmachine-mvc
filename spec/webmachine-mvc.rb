=begin
Copyright 2013 Lars Olsson <lasso@lassoweb.se>

This file is part of webmachine-mvc.

Webmachine-mvc is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Webmachine-mvc is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with webmachine-mvc. If not, see <http://www.gnu.org/licenses/>.
=end

require 'webmachine/test'
Dir.chdir('app') do
  require_relative 'app/app.rb'
end

describe MyApp do

  include Webmachine::Test

  let(:app) { MyApp }

  describe 'GET index page' do
    it 'Returns a 200 OK status code' do
      get '/index'
      response.code.should == 200
    end

    it 'Contains the String "Welcome to Webmachine!"' do
      get '/index'
      response.body.should == 'Welcome to Webmachine!'
    end

    it 'Have the content type text/html' do
      get '/index'
      response.headers['Content-Type'].should == 'text/html'
    end
  end
end
