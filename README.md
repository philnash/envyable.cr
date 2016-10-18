# Envyable

The simplest yaml to `ENV` config loader.

[![Build Status](https://travis-ci.org/philnash/envyable.cr.svg?branch=master)](https://travis-ci.org/philnash/envyable.cr)

Envyable takes a config YAML file and loads the entries into your `ENV` hash. Keep your development environment clean of application specific configuration.

## Installation

It is only recommended that you use Envyable in your development environment. There are better ways to set environment variables in production.

Add this to your application's `shard.yml`:

```yaml
development_dependencies:
  envyable:
    github: philnash/envyable.cr
```

## Usage

You will need a YAML file which contains your application config. I like to use `config/env.yml`. Put your default settings in the root and then override them on an environment by environment basis.

### Example YAML file

The following YAML file sets the `API_CLIENT_ID` in all environments to `"development-id"` then overrides it in the test environment to `"test-id"`.

```yaml
API_CLIENT_ID: development-id
test:
  API_CLIENT_ID: test-id
```

### Load the configuration

To load the configuration you just need to require the library and then call `load`.

```crystal
require "envyable"
Envyable.load("path/to/yml", "development")
```

All config is loaded as a string.

By default the development environment will be loaded. If you have a config file called `env.yml` in the `config` directory and you wanted to load the development environment, then you would include the following:

```crystal
require "envyable"
Envyable.load("./config/env.yml")
```

## Version control

It is not recommended that you check the YAML file in to version control. I like to check in a `env.yml.example` file that shows the required keys, but does not include any credentials.

## Contributing

1. Fork it ( https://github.com/philnash/envyable.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Phil Nash](https://github.com/philnash) - creator, maintainer
