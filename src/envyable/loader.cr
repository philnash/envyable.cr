require "yaml"
require "file"

module Envyable
  # Internal: Loads yaml files into ENV (or a supplied hash).
  class Loader
    # Internal: Returns the String or Pathname path of the loader
    getter :path

    # Internal: Returns the Hash loadable of the loader
    getter :loadable

    # Internal: initalize a Loader
    #
    # path      - a Pathname or String that describes where the yaml file
    #             resides.
    # loadable  - a Hash(String, String) or hashlike structure that the yaml
    #             file variables should be loaded into (default: ENV).
    def initialize(@path : String, @loadable : (Hash(String, String) | ENV.class) = ENV)
    end

    # Internal: perform the loading from the given environment
    #
    # environment - a String describing the environment from which to load the
    #               variables (default: development).
    #
    # Examples
    #
    # load("production")
    #
    # Returns nothing.
    def load(environment = "development")
      load_yml.as_h?.try do |hash|
        hash.each { |key, value| set_value(key, value) }
        hash.fetch(environment, YAML::Any.new(nil)).as_h?.try do |env_hash|
          env_hash.each { |key, value| set_value(key, value) }
        end
      end
    end

    private def load_yml : YAML::Any
      yml_path = File.expand_path(@path)
      if File.exists?(yml_path)
        contents = File.read(yml_path)
        return YAML.parse(contents)
      else
        return YAML::Any.new(nil)
      end
    end

    private def set_value(key, value)
      @loadable[key.to_s] = value.to_s unless value.raw.is_a?(Hash)
    end
  end
end
