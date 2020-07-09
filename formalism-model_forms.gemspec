# frozen_string_literal: true

require 'date'

Gem::Specification.new do |spec|
	spec.name          = 'formalism-model_forms'
	spec.version       = '0.1.0'
	spec.date          = Date.today.to_s
	spec.summary       = 'Standard Formalism forms for Sequel Models'
	spec.description   = <<~DESC
		Standard Formalism forms for Sequel Models, such like create, find, delete, etc.
	DESC
	spec.authors       = ['Alexander Popov', 'Ivan Tyurin']
	spec.email         = 'alex.wayfer@gmail.com'
	spec.files         = Dir['lib/**/*.rb', 'README.md', 'LICENSE.txt', 'CHANGELOG.md']
	spec.homepage      = 'https://github.com/AlexWayfer/formalism-model_forms'
	spec.license       = 'MIT'

	spec.required_ruby_version = '>= 2.5.0'

	spec.add_dependency 'alt_memery', '~> 2.0'
	spec.add_dependency 'flame-pagination', '~> 0.2.0'
	spec.add_dependency 'formalism', '~> 0.1.0'
	spec.add_dependency 'gorilla_patch', '~> 4.0'
	spec.add_dependency 'module_methods', '~> 0.1.0'
	spec.add_dependency 'sequel', '~> 5.0'

	spec.add_development_dependency 'pry-byebug', '~> 3.9'

	spec.add_development_dependency 'bundler', '~> 2.0'
	spec.add_development_dependency 'gem_toys', '~> 0.2.0'
	spec.add_development_dependency 'toys', '~> 0.10.0'

	spec.add_development_dependency 'codecov', '~> 0.1.0', '!= 0.1.18', '!= 0.1.19'
	spec.add_development_dependency 'rspec', '~> 3.9'
	spec.add_development_dependency 'simplecov', '~> 0.18.0'

	spec.add_development_dependency 'rubocop', '~> 0.87.0'
	spec.add_development_dependency 'rubocop-performance', '~> 1.0'
	spec.add_development_dependency 'rubocop-rspec', '~> 1.0'
end
