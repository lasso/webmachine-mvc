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

require 'webmachine'
require_relative '../../lib/webmachine-mvc'

# Configure Webmachine
Webmachine.application.configure do |config|
  config.adapter = :Reel
  config.port = 8000
end

Webmachine::MVC.preload_template_libraries(:haml)

# Set up Webmachine::MVC
Webmachine::MVC.setup()

# Bind Webmachine application to class for testing
MyApp = Webmachine.application

# If started from the command line, run the application
if File.expand_path(__FILE__) == File.expand_path($0)
  Webmachine.application.run
end
