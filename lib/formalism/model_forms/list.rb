# frozen_string_literal: true

require 'flame/pagination/for_forms'

module Formalism
	module ModelForms
		## Base form for model listing
		module List
			include Formalism::ModelForms::Base
			include Memery
			extend ModelForms::Base::Plural

			## Module for class methods
			module ClassMethods
				include Memery
				using GorillaPatch::Namespace

				memoize def namespace
					return super if super.demodulize != 'List'

					self::FORMS_NAMESPACE.const_get(super.deconstantize, false)
				end

				def search_fields(*fields)
					@search_fields ||= Set.new
					return @search_fields if fields.empty?

					@search_fields.merge(fields)
				end

				def inherited(list_form)
					super

					list_form.search_fields(*search_fields)
				end
			end

			EAGER = %i[].freeze

			include Flame::Pagination::ForForms

			field :search_query, merge: false

			memoize def dataset
				return select_cached if @cached

				dataset =
					ordered_unfiltered_dataset
						.where(conditions_for_dataset)
						.eager(*self.class::EAGER)

				return dataset unless dataset.respond_to? :search

				dataset.search(search_query, self.class.search_fields)
			end

			memoize def dataset_edges
				[dataset.first, dataset.last]
			end

			private

			def execute
				self.instance =
					if dataset
						@cached ? cached_dataset_for_execute : non_cached_dataset_for_execute.all
					else
						[]
					end
			end

			def unfiltered_dataset
				model.dataset
			end

			def ordered_unfiltered_dataset
				result = unfiltered_dataset.from_self(alias: model.table_name)
				result = result.reverse_order(:created_at) unless unfiltered_dataset.opts[:order]
				result
			end

			def cached_dataset_for_execute
				limit_by_page ? dataset[limit_by_page] : dataset
			end

			def non_cached_dataset_for_execute
				dataset.where(
					primary_field_name => dataset.select(primary_field_name).limit(limit_by_page)
				)
			end
		end
	end
end
