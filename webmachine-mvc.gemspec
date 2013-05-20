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

require 'rake'

Gem::Specification.new do |spec|
	spec.name					=	'webmachine-mvc'
	spec.version			=	'0.0.1'
	spec.date					= Time.now.strftime('%Y-%m-%d')
	spec.summary			= 'MVC for Webmachine'
	spec.description	=	'MVC for Webmachine'
	spec.author				=	'Lars Olsson'
	spec.email				= 'lasso@lassoweb.se'
	spec.files				= ::Rake::FileList['lib/**/*'] <<
                        'COPYING' << 'LICENCE.md' << 'Rakefile' << 'README.md'

  spec.test_files   = ::Rake::FileList['spec/**/*']

	spec.homepage			= 'http://www.lassoweb.se/ruby/webmachine-mvc'

  spec.license      = 'GNU GPL (version 3 or later)'

  # Dependencies
  spec.add_dependency('webmachine', '>= 1.1.0')

  # Development dependencies
  spec.add_development_dependency('rspec', '>= 2.13.0')
  spec.add_development_dependency('webmachine-test', '>= 0.2.1')

end
