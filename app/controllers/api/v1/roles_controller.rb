class Api::V1::RolesController < ApplicationController

  def roles_select
    @roles = Role.no_super.all.collect{|role| { id: role.id, name: role.name} }
    render json: {roles: @roles}, status: :ok
  end
end
