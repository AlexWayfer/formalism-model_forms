# frozen_string_literal: true

describe Formalism::ModelForms::Find do
	shared_examples 'correct behavior' do
		describe '.namespace' do
			subject { super().namespace }

			it { is_expected.to eq MyProject::Forms::User }
		end

		describe '#initialize' do
			subject { super().new(id_or_instance) }

			let(:expected_attrs) { { id: 42, name: 'Alex', age: 25 } }
			let(:instance) { MyProject::Models::User.find(id: 42) }

			context 'when there is an instance' do
				let(:id_or_instance) { instance }

				describe '#instance' do
					subject { super().instance }

					it { is_expected.to eq instance }
				end

				describe '#to_params' do
					subject { super().to_params }

					it { is_expected.to eq expected_attrs }
				end
			end

			context 'when there is an id' do
				let(:id_or_instance) { { id: 42 } }

				describe '#instance' do
					subject { super().instance }

					it { is_expected.to eq instance }
				end

				describe '#to_params' do
					subject { super().to_params }

					it { is_expected.to eq(id: 42) }
				end
			end
		end
	end

	describe MyProject::Forms::User::Find do
		subject { described_class }

		include_examples 'correct behavior'
	end

	describe MyProject::Forms::User::FindRefined do
		subject { described_class }

		include_examples 'correct behavior'
	end
end
