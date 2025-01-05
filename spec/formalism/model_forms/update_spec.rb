# frozen_string_literal: true

describe Formalism::ModelForms::Update do
	describe MyProject::Forms::User::Update do
		subject { described_class }

		describe '.namespace' do
			subject { super().namespace }

			it { is_expected.to eq MyProject::Forms::User }
		end

		describe '#initialize' do
			subject { super().new(params, id_or_instance) }

			let(:expected_attrs) { { id: 42, name: 'Alex', age: 25 } }
			let(:instance) { MyProject::Models::User.find(id: 42) }

			context 'when there is an instance' do
				let(:id_or_instance) { instance }

				context 'when params are refined' do
					let(:params) { { name: 'Ivan' } }

					describe '#instance' do
						subject { super().instance }

						it { is_expected.to eq id_or_instance }
					end

					describe '#to_params' do
						subject { super().to_params }

						it { is_expected.to eq expected_attrs.merge(params) }
					end
				end

				context 'when params are empty' do
					let(:params) { {} }

					describe '#instance' do
						subject { super().instance }

						it { is_expected.to eq id_or_instance }
					end

					describe '#to_params' do
						subject { super().to_params }

						it { is_expected.to eq expected_attrs }
					end
				end

				context 'when params are `nil`' do
					let(:params) { nil }

					describe '#instance' do
						subject { super().instance }

						it { is_expected.to eq id_or_instance }
					end

					describe '#to_params' do
						subject { super().to_params }

						it { is_expected.to eq expected_attrs }
					end
				end
			end
		end
	end
end
