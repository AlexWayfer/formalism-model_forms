# frozen_string_literal: true

describe Formalism::ModelForms do
	describe MyProject::Forms::User::Create do
		subject { described_class }

		describe '.namespace' do
			subject { super().namespace }

			it { is_expected.to eq MyProject::Forms::User }
		end
	end
end
