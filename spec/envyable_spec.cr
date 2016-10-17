require "./spec_helper"

describe Envyable do
  describe ".load" do
    it "should load a yml settings file" do
      Envyable.load "spec/fixtures/env.yml"
      ENV["CHUNKY"].should eq("bacon")
    end

    it "should take an optional environment argument" do
      Envyable.load "spec/fixtures/env.yml", "staging"
      ENV["CHUNKY"].should eq("foxes")
    end

    it "should not fail if file is not there" do
      Envyable.load "spec/fixtures/nothing.yml"
    end

    it "should not fail if the environment is not represented in the file" do
      Envyable.load "spec/fixtures/env.yml", "production"
    end
  end
end
