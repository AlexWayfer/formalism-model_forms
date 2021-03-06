# frozen_string_literal: true

module Formalism
	module ModelForms
		## Base form for model deletion
		module Delete
			include Formalism::ModelForms::Base

			# module ClassMethods
			# 	def inherited(form)
			# 		super
			#
			# 		return unless form.model.auditable?
			#
			# 		form.include RequiredChangesAuthor
			# 	end
			# end

			primary_field :id, Integer

			private

			def execute
				if model.respond_to?(:auditable?) && model.auditable?
					instance.changes_author = changes_author
				end

				instance.destroy
				super
			end
		end
	end
end
