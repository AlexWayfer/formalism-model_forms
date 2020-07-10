# frozen_string_literal: true

require 'formalism'
require 'module_methods'

Dir["#{__dir__}/model_forms/**/*.rb"].sort.each { |file| require file }

module Formalism
	## Module for model forms
	module ModelForms
		class << self
			def define_for_project(
				project_namespace,
				forms_namespace: project_namespace::Forms,
				models_namespace: (project_namespace::Models if project_namespace.const_defined?(:Models))
			)
				forms_namespace.const_set :Model, Module.new

				define_model_base_form forms_namespace, models_namespace

				define_other_model_forms forms_namespace
			end

			private

			def define_model_base_form(forms_namespace, models_namespace)
				forms_namespace::Model.const_set :Base, (Class.new(forms_namespace::Base) do
					include ModelForms::Base

					const_set :FORMS_NAMESPACE, forms_namespace
					const_set :MODELS_NAMESPACE, models_namespace
				end)
			end

			def define_other_model_forms(forms_namespace)
				%i[Create Delete Find FindOrCreate List Move Update].each do |form_name|
					forms_namespace::Model.const_set form_name, (Class.new(forms_namespace::Model::Base) do
						include ModelForms.const_get(form_name, false)
					end)
				end

				forms_namespace::Model.const_set :Select, (Class.new(forms_namespace::Model::Find) do
					include ModelForms::Select
				end)
			end
		end
	end
end
