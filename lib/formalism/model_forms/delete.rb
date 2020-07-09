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

			field :id, Integer

			private

			def execute
				instance.changes_author = changes_author if model.auditable?

				instance.destroy
				super
			end
		end
	end
end
