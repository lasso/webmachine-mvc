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

    # Class representing a controller in Webmachine::MVC.
    class Controller

      # :nodoc
      def self.after_inherited(child)
        puts "Inherited by #{child}."
        if child.mapping.nil?
          raise RuntimeError.new('No mapping provided')
        end
        child.public_instance_methods(false).each do |meth|
          puts "Wrapping #{meth}"
          resource = Class.new(Webmachine::Resource) do
            define_method(:to_html) do
              instance = child.new
              result = instance.send(meth)
              engine, options = child.template_engine.call(meth)
              unless engine.nil?
                options ||= {} # If no options are given, just use an empty hash
                Webmachine::MVC::View.create_view(
                  instance, meth, engine, options
                ).render()
              else
                result
              end
            end
          end
          self.add_resource(self.extract_path(child, meth), resource)
        end
      end

      # :nodoc
      def self.defined(*args)
        if superclass.respond_to?(:after_inherited)
          superclass.after_inherited(self)
        end
      end

      # Maps the controller to a path.
      # @param [String] path
      def self.map(path)
        path = path.to_s
        if path.empty? || path[0] != '/'
          raise new RuntimeError('Invalid path')
        end
        puts "Mapping #{self} to #{path}."
        Webmachine::MVC.add_mapping(path, self)
      end

      # Returns the mapping for the current controller.
      #
      # @return [String]
      def self.mapping()
        Webmachine::MVC.mappings_by_controller.fetch(self, nil)
      end

      # Returns the list och Webmachine::Resource objects associated
      # with the current controller.
      #
      # @return [Hash]
      def self.resources
        @@resources ||= {}
      end

      # Returns the template engine associated withe current controller.
      # Since the templating engine may be different for different
      # methods, this method will return always return a Proc object.
      # To get the engine used for a specific method, use
      # template.engine.call(:some_meth)
      #
      # @return [Proc]
      def self.template_engine()
        @@template_engine ||= lambda { |meth| nil }
      end

      # Sets the templating engine used by the current controller. If a
      # block is given, it is used at runtime to decide which templating
      # engine to use. If a symbol is given that templating engine will
      # always be used.
      #
      # @param [Symbol] name
      # @return [nil]
      def self.use_template_engine(name = nil, &block)
        @@uses_templates = true
        if block_given?
          @@template_engine = block
        else
          @@template_engine = lambda { |meth| name }
        end
        nil
      end

      # Returns whether the current controller class uses templates or not.
      #
      # @return [true|false]
      def self.uses_templates
        @@uses_templates ||= false
      end

      private

      def self.add_resource(path, resource)
        self.resources[strpath(path)] = resource
        Webmachine.application.routes do
          add path, resource
        end
      end

      def self.extract_path(klass, meth)
        path_arr = [klass.mapping[1..-1], meth.to_s].reject! do |elem|
          elem.empty?
        end
        meth_obj = klass.instance_method(meth)
        meth_obj.parameters.each do |param|
          path_arr <<  param.last if param.first == :req
        end
        path_arr
      end

      def self.strpath(arr_path)
        arr_path.inject('') do |memo, elem|
          memo << '/'
          memo << (elem.is_a?(Symbol) ? elem.inspect : elem.to_s)
        end
      end

    end

  end

end
