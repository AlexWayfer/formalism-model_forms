# frozen_string_literal: true

## `stub_const` sets `.name` after `.inherited` of parent class
module MyProject
	module Models
		class User
		end
	end

	module Forms
		class Base < Formalism::Form
		end
	end

	Formalism::ModelForms.define_for_project self

	module Forms
		module User
			class Create < Forms::Model::Create
			end
		end
	end
end

describe Formalism::ModelForms do
	describe MyProject::Forms::User::Create do
		subject { described_class }

		describe '.namespace' do
			subject { super().namespace }

			it { is_expected.to eq MyProject::Forms::User }
		end
	end
end
