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

task :default => [:list_tasks]

desc 'Creates the documentation files.'
task :doc do
  system 'yard --list-undoc'
end

desc 'Lists available tasks.'
task :list_tasks do
  system 'rake -T'
end

desc 'Runs the specs'
task :spec do
  Dir.chdir ('spec') do
    system 'rspec webmachine-mvc.rb'
  end
end

desc 'Runs the specs'
task :test => [:spec]
