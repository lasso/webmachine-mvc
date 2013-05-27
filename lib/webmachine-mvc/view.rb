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

module Webmachine

  module MVC

    # Class representing a view in Webmachine::MVC,
    class View

      # Constructor
      #
      # @param [String] template
      # @param [Object] data
      # @param [Symbol] engine_class
      # @param [Hash] options
      def initialize(template, data = Object.new, engine_class = nil, options = {})
        @template = template
        @data = data
        @engine_class = engine_class
        @options = options
      end

      # Renders the view and returns the resulting string.
      #
      # @return [String]
      def render()
        unless @engine_class.nil?
          renderer = @engine_class.new(@template, @options)
        else
          renderer = Tilt.new(@template, @options)
        end
        renderer.render(@data)
      end

      # Helper method for creating a view tied to a controller action.
      #
      # @param [Webmachine::MVC::Controller] controller
      # @param [Symbol] method
      # @param [Symbol] engine
      # @param [Hash] options
      def self.create_view(controller, method, engine, options = {})
        engine = engine.to_s.downcase
        unless Tilt.mappings.has_key?(engine)
          raise RuntimeError.new('No such engine')
        end
        engine_class = Tilt[engine]
        template =
          File.join(
            File.expand_path(Webmachine::MVC.view_directory),
            controller.class.mapping,
            "#{method}.#{engine}"
          )
        self.new(template, controller, engine_class, options)
      end

    end

  end

end
