class Api::V1::UserLogsController < ApplicationController

  # GET /logs
  # GET /logs.json
  def index
    q = UserLog.ransack( params[:q] )
    logs = UserLog
    @logs = q.result.joins(:user,:account).all

  end
end
