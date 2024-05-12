# frozen_string_literal: true

module User
  module Query
    module GetTeamQuery
      def call(id)
        team = User::TeamRecord.find(id)
        User::Query::Team.from_record(team)
      end

      module_function :call
    end
  end
end
