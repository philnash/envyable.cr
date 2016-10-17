require "./../spec_helper"

describe Envyable::Loader do
  it "should initialize with a path" do
    loader = Envyable::Loader.new(".")
    loader.should be_a(Envyable::Loader)
  end

  # it "needs a path to initialize" do
  #   expect_raises(ArgumentError) do
  #     Envyable::Loader.new
  #   end
  # end

  it "can be loaded with a path, environment and loadable hash" do
    hash = {} of String => String
    loader = Envyable::Loader.new(".", hash)
    loader.loadable.should eq(hash)
  end

  describe "initialized with just a path" do
    it "should have access to the path" do
      loader = Envyable::Loader.new("spec/fixtures/env.yml")
      loader.path.should eq("spec/fixtures/env.yml")
    end

    it "should default to loading to the ENV" do
      loader = Envyable::Loader.new("spec/fixtures/env.yml")
      loader.loadable.should eq(ENV)
    end
  end

  describe "initialized with a path and a loadable hash" do
    describe "loading the default development env" do
      it "should load variables from the yaml file into the loadable hash" do
        loadable = {} of String => String
        loader = Envyable::Loader.new("spec/fixtures/env.yml", loadable)
        loader.load
        loadable["CHUNKY"].should eq("bacon")
      end

      it "should load all items as strings" do
        loadable = {} of String => String
        loader = Envyable::Loader.new("spec/fixtures/env.yml", loadable)
        loader.load
        loadable["NUMBER"].should eq("3")
      end
    end

    describe "loading the staging env" do
      it "should load variables from the yaml file into the loadable hash" do
        loadable = {} of String => String
        loader = Envyable::Loader.new("spec/fixtures/env.yml", loadable)
        loader.load("staging")
        loadable["CHUNKY"].should eq("foxes")
      end

      it "should load all items as strings" do
        loadable = {} of String => String
        loader = Envyable::Loader.new("spec/fixtures/env.yml", loadable)
        loader.load("staging")
        loadable["NUMBER"].should eq("5")
      end
    end
  end

  describe "initialized with a path to an env with default values and a loadable hash" do
    describe "loading the default development environment" do
      it "should load default values into the loadable" do
        loadable = {} of String => String
        loader = Envyable::Loader.new("spec/fixtures/default_env.yml", loadable)
        loader.load
        loadable["CHUNKY"].should eq("bacon")
        loadable["NUMBER"].should eq("3")
      end

      it "should not load a key for environment specific values" do
        loadable = {} of String => String
        loader = Envyable::Loader.new("spec/fixtures/default_env.yml", loadable)
        loader.load
        loadable["staging"]?.should be_nil
      end
    end

    describe "loading the staging environment" do
      it "should overwrite the default values" do
        loadable = {} of String => String
        loader = Envyable::Loader.new("spec/fixtures/default_env.yml", loadable)
        loader.load("staging")
        loadable["CHUNKY"].should eq("foxes")
      end

      it "should still load the other default values" do
        loadable = {} of String => String
        loader = Envyable::Loader.new("spec/fixtures/default_env.yml", loadable)
        loader.load("staging")
        loadable["NUMBER"].should eq("3")
      end
    end
  end
end
