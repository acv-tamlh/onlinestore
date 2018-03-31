class RegistrationsController < Devise::RegistrationsController

protected
  def update_resource(resource, params)
    resource.update_without_password(params)
    order = current_order
    order.update!(user_id: current_user.id)
  end
end
