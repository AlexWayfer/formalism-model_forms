# frozen_string_literal: true

require_relative 'lib/formalism/model_forms/version'

Gem::Specification.new do |spec|
	spec.name          = 'formalism-model_forms'
	spec.version       = Formalism::ModelForms::VERSION
	spec.summary       = 'Standard Formalism forms for Sequel Models'
	spec.description   = <<~DESC
		Standard Formalism forms for Sequel Models, such like create, find, delete, etc.
	DESC
	spec.authors       = ['Alexander Popov', 'Ivan Tyurin']
	spec.email         = 'alex.wayfer@gmail.com'
	spec.files         = Dir['lib/**/*.rb', 'README.md', 'LICENSE.txt', 'CHANGELOG.md']
	spec.license       = 'MIT'

	source_code_uri = 'https://github.com/AlexWayfer/formalism-model_forms'

	spec.homepage = source_code_uri

	spec.metadata['source_code_uri'] = source_code_uri

	spec.metadata['homepage_uri'] = spec.homepage

	spec.metadata['changelog_uri'] =
		'https://github.com/AlexWayfer/formalism-model_forms/blob/main/CHANGELOG.md'

	spec.metadata['rubygems_mfa_required'] = 'true'

	spec.required_ruby_version = '>= 2.6', '< 4'

	spec.add_dependency 'alt_memery', '~> 2.0'
	spec.add_dependency 'flame-pagination', '~> 0.3.0'
	spec.add_dependency 'formalism', '~> 0.5.0'
	spec.add_dependency 'gorilla_patch', '~> 4.0'
	spec.add_dependency 'module_methods', '~> 0.1.0'
	spec.add_dependency 'sequel', '~> 5.0'

	spec.add_development_dependency 'pry-byebug', '~> 3.9'

	spec.add_development_dependency 'bundler', '~> 2.0'
	spec.add_development_dependency 'gem_toys', '~> 0.12.1'
	spec.add_development_dependency 'toys', '~> 0.13.0'

	spec.add_development_dependency 'codecov', '~> 0.6.0'
	spec.add_development_dependency 'rspec', '~> 3.9'
	spec.add_development_dependency 'simplecov', '~> 0.21.0'
	spec.add_development_dependency 'simplecov-cobertura', '~> 2.1'

	spec.add_development_dependency 'rubocop', '~> 1.36.0'
	spec.add_development_dependency 'rubocop-performance', '~> 1.0'
	spec.add_development_dependency 'rubocop-rspec', '~> 2.0'
end
