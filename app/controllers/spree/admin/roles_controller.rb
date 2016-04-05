module Spree
  module Admin
    class RolesController < ResourceController

      def create
        @role.attributes = role_params
        if @role.save

          Spree::RoleConfiguration.configure do |config|
            config.assign_permissions @role.name, @role.permission_sets_constantized
          end

          flash[:success] = flash_message_for(@role, :successfully_created)
          respond_with(@role) do |format|
            format.html { redirect_to location_after_save }
            format.js   { render :layout => false }
          end
        else
          invoke_callbacks(:create, :fails)
          respond_with(@role) do |format|
            format.html do
              flash.now[:error] = @role.errors.full_messages.join(", ")
              render_after_create_error
            end
            format.js { render layout: false }
          end
        end
      end

      def update
        invoke_callbacks(:update, :before)
        if @role.update_attributes(role_params)
          invoke_callbacks(:update, :after)

          Spree::RoleConfiguration.configure do |config|
            config.assign_permissions @role.name, @role.permission_sets_constantized
          end

          respond_with(@role) do |format|
            format.html do
              flash[:success] = flash_message_for(@role, :successfully_updated)
              redirect_to location_after_save
            end
            format.js { render :layout => false }
          end
        else
          invoke_callbacks(:update, :fails)
          respond_with(@role) do |format|
            format.html do
              flash.now[:error] = @role.errors.full_messages.join(", ")
              render_after_update_error
            end
            format.js { render layout: false }
          end
        end
      end

      def role_params
        params.require(:role).permit(:name, permission_set_ids: [])
      end
    end
  end
end