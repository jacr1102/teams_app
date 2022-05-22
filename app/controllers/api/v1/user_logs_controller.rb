class Api::V1::UserLogsController < ApplicationController
  before_action :set_log, only: %i[ show update destroy ]

  # GET /logs
  # GET /logs.json
  def index

    name       = params[:name]
    account_id = params[:account]
    start_date = params[:start_date]
    end_date   = params[:end_date]

    logs = UserLog.joins(:user,:account)

    if name
      logs.or( UserLog.where( "users.first_name LIKE ?", "%#{name}%") )
        .or( UserLog.where( "users.last_name LIKE ?", "%#{name}%") )
    end

    logs.where( account_id: account_id ) if account_id
    logs.where( created_at: start_date.. ) if start_date
    logs.where( created_at: ..end_date ) if end_date

    @logs = logs.all

  end
end
