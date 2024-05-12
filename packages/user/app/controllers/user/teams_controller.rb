# frozen_string_literal: true

module User
  class TeamsController < User::ApplicationController
    before_action :authenticate_user_account!

    def index
      @teams = User::TeamRepository.all
    end

    def show
      @team = User::TeamRepository.find(id: params[:id])
      @user_accounts = User::AccountRepository.all
      @form = User::Forms::TeamForm.new(name: @team.name, user_accounts: @team.members&.map(&:id) || [])
    end

    def create
      @team = User::TeamRepository.create
    end

    def update
      id = params[:id]
      name = params[:user_forms_team_form][:name]
      team_members = params[:user_forms_team_form][:user_accounts].presence&.map do |user_account_id|
        User::TeamMember.new(user_account_id: user_account_id.to_i, user_team_id: id)
      end
      if User::TeamRepository.update(id: id, name: name, members: team_members || [])
        redirect_to user_team_path(id), notice: 'チームを更新しました', status: :see_other
      else
        @team = User::TeamRepository.find(id: id)
        @form = User::Form::TeamForm.new(name: name, user_accounts: team_members&.map(&:user_account_id) || [])
        flash.now[:alert] = 'チームの更新に失敗しました'
        render :show, status: :unprocessable_entity
      end

    end

    def destroy
      User::TeamRepository.destroy(id: params[:id])
      redirect_to user_teams_path, notice: 'チームを削除しました', status: :see_other
    end
  end
end