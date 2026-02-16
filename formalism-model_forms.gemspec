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

	spec.required_ruby_version = '>= 3.2', '< 3.5'

	spec.add_dependency 'alt_memery', '~> 3.0'
	spec.add_dependency 'flame-pagination', '~> 1.0'
	spec.add_dependency 'formalism', '~> 1.0'
	spec.add_dependency 'gorilla_patch', '>= 4.0', '< 7'
	spec.add_dependency 'module_methods', '~> 1.0'
	spec.add_dependency 'sequel', '~> 5.0'
end
