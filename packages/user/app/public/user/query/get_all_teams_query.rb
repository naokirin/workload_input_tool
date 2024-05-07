# frozen_string_literal: true

module User
  module Query
    module GetAllTeamsQuery
      def call
        User::TeamRecord.all.map do |team|
          User::Query::Team.from_record(team)
        end
      end

      module_function :call
    end
  end
end
