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

# Main namespace for Webmachine.
module Webmachine

  # Namespace for all Webmachine::MVC functionality.
  module MVC

    # Adds a mapping between a controller and a path.
    #
    # @param [String] path
    # @param [Class] controller_class
    # @return [nil]
    def self.add_mapping(path, controller_class)
      self._configuration.add_mapping(path, controller_class)
      nil
    end

    # Returns a copy of the current configuration. Changing the returned
    # object will *not* affect the configuration of Webmachine::MVC.
    #
    # @return [Struct]
    def self.configuration()
      self._configuration.data.dup
    end

    # Returns the controller directory used by Webmachine::MVC.
    #
    # @return [String]
    def self.controller_directory()
      self._configuration.controller_directory
    end

    # Sets the controller directory used by Webmachine::MVC. This
    # method should only be called *before* the setup method is
    # called, otherwise a RuntimeError will be raised.
    #
    # @param [String] path A path in the file system
    # @return [nil]
    # @raise [RuntimeError] if setup has already been called
    # @raise [ArgumentError] if path does not exist or is unreadable
    def self.controller_directory=(path)
      self._configuration.controller_directory = path
    end

    # Returns a list of mappings between controller -> path.
    #
    # @return [Hash]
    def self.mappings_by_controller()
      self._configuration.mappings_by_controller()
    end

    # Returns a list of mappings between path -> controller.
    #
    # @return [Hash]
    def self.mappings_by_path()
      self._configuration.mappings_by_path()
    end

    # Initializes the Webmachine::MVC framework.
    #
    # @return [nil]
    def self.setup()
      self._configuration.setup()
    end

    # Returns the view directory used by Webmachine::MVC.
    #
    # @return [String]
    def self.view_directory()
      self._configuration.view_directory
    end

    # Sets the view directory used by Webmachine::MVC. This
    # method should only be called *before* the setup method is
    # called, otherwise a RuntimeError will be raised.
    #
    # @param [String] path A path in the file system
    # @return [nil]
    # @raise [RuntimeError] if setup has already been called
    # @raise [ArgumentError] if path does not exist or is unreadable
    def self.view_directory=(path)
      self._configuration.view_directory = path
    end

    private

    def self._configuration
      @configuration = Class.new do

        define_method(:initialize) do
          @data =
            Struct.new(
              'Data',
              :controller_directory, :view_directory,
              :mappings_by_controller, :mappings_by_path,
              :setup_done
            ).new
          @data.controller_directory = File.expand_path('controllers')
          @data.view_directory = File.expand_path('views')
          @data.mappings_by_controller = {}
          @data.mappings_by_path = {}
          @data.setup_done = false
        end

        define_method(:add_mapping) do |path, controller_class|
          @data.mappings_by_controller[controller_class] = path
          @data.mappings_by_path[path] = controller_class
          nil
        end

        define_method(:controller_directory) do
          @data.controller_directory
        end

        define_method(:controller_directory=) do |path|
          raise RuntimeError.new(
            'Cannot change controller directory path after setup'
          ) if @data.setup_done
          path = File.expand_path(path)
          raise ArgumentError.new(
            'Path does not exist'
          ) unless File.exists?(path)
          raise ArgumentError.new(
            'Path is not a directory'
          ) unless File.directory?(path)
          raise ArgumentError.new(
            'Path is not readable'
          ) unless File.readable?(path)
          @data.controller_directory = path
          nil
        end

        define_method(:data) do
          @data
        end

        define_method(:mappings_by_controller) do
          @data.mappings_by_controller
        end

        define_method(:mappings_by_path) do
          @data.mappings_by_path
        end

        define_method(:setup) do
          raise RuntimeError.new(
            'Cannot run setup more than once'
          ) if @data.setup_done
          setup_controllers()
          setup_views()
          @data.setup_done = true
          nil
        end

        define_method(:view_directory) do
          @data.view_directory
        end

        define_method(:view_directory=) do |path|
          raise RuntimeError.new(
            'Cannot change view directory path after setup'
          ) if @data.setup_done
          path = File.expand_path(path)
          raise RuntimeError.new(
            'Path does not exist'
          ) unless File.exists?(path)
          raise RuntimeError.new(
            'Path is not a directory'
          ) unless File.directory?(path)
          raise RuntimeError.new(
            'Path is not readable'
          ) unless File.readable?(path)
          @data.view_directory = path
          nil
        end

        define_method(:setup_controllers) do
          require 'defined'
          require File.join(File.dirname(__FILE__), 'webmachine-mvc/controller.rb')
          Defined.enable!
          Dir.chdir(File.expand_path(self.controller_directory)) do
            Dir.glob('**/*Controller.rb').each do |controller|
              require File.expand_path(controller)
            end
          end
          Defined.disable!
          nil
        end

        private :setup_controllers

        define_method(:setup_views) do
          # TODO: Don't load views unless any controller uses them
          require 'tilt'
          require File.join(File.dirname(__FILE__), 'webmachine-mvc/view.rb')
          nil
        end

        private :setup_views

      end.new unless defined?(@configuration)

      # Return configuration
      @configuration
    end

  end

end
