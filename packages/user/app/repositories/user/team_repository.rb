# frozen_string_literal: true

module User
  module TeamRepository
    def all
      User::TeamRecord.all.map { |record| User::Team.from_record(record) }
    end

    def find(id:)
      record = User::TeamRecord.find(id)
      User::Team.from_record(record)
    end

    def create
      User::TeamRecord.create(name: '新規チーム')
    end

    def update(id:, name:, members: [])
      ActiveRecord::Base.transaction do
        record = User::TeamRecord.find(id)
        record.update!(name:)
        record.team_members.each(&:destroy!)
        members.each do |member|
          record.team_members.create!(user_account_id: member.user_account_id, user_team_id: id)
        end
      end
    end

    def destroy(id:)
      User::TeamRecord.find(id).destroy
    end

    module_function :all, :find, :create, :update, :destroy
  end
end
