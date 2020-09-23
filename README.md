# Formalism Model Forms

[![Cirrus CI - Base Branch Build Status](https://img.shields.io/cirrus/github/AlexWayfer/formalism-model_forms?style=flat-square)](https://cirrus-ci.com/github/AlexWayfer/formalism-model_forms)
[![Codecov branch](https://img.shields.io/codecov/c/github/AlexWayfer/formalism-model_forms/master.svg?style=flat-square)](https://codecov.io/gh/AlexWayfer/formalism-model_forms)
[![Code Climate](https://img.shields.io/codeclimate/maintainability/AlexWayfer/formalism-model_forms.svg?style=flat-square)](https://codeclimate.com/github/AlexWayfer/formalism-model_forms)
[![Depfu](https://img.shields.io/depfu/AlexWayfer/benchmark_toys?style=flat-square)](https://depfu.com/repos/github/AlexWayfer/formalism-model_forms)
[![Inline docs](https://inch-ci.org/github/AlexWayfer/formalism-model_forms.svg?branch=master)](https://inch-ci.org/github/AlexWayfer/formalism-model_forms)
[![License](https://img.shields.io/github/license/AlexWayfer/formalism-model_forms.svg?style=flat-square)](LICENSE.txt)
[![Gem](https://img.shields.io/gem/v/formalism-model_forms.svg?style=flat-square)](https://rubygems.org/gems/formalism-model_forms)

Ruby gem with standard [Formalism](https://github.com/AlexWayfer/formalism) forms
for ([Sequel](https://sequel.jeremyevans.net/)) models.
Used by [Flame Generate Toys](https://github.com/AlexWayfer/flame_generate_toys).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'formalism-model_forms'
```

And then execute:

```shell
bundle install
```

Or install it yourself as:

```shell
gem install formalism-model_forms
```

## Usage

```ruby
module Users
  class Create < Formalism::ModelForms::Create
    field :name

    private

    def validate
      if name.to_s.empty?
        errors.add 'Name is not provided'
      end
    end

    # `execute` is inherited from `Formalism::ModelForms`
  end
end
```

## Development

After checking out the repo, run `bundle install` to install dependencies.

Then, run `toys rspec` to run the tests.

To install this gem onto your local machine, run `toys gem install`.

To release a new version, run `toys gem release %version%`.
See how it works [here](https://github.com/AlexWayfer/gem_toys#release).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/AlexWayfer/formalism).

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
