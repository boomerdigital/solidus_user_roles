# frozen_string_literal: true

Deface::Override.new(
  virtual_path: 'spree/admin/shared/_menu',
  name: 'add_user_roles_menu_links',
  insert_bottom: "[data-hook='admin_tabs']"
) do
  <<-HTML
    <% if can? :admin, Spree::Role %>
      <%= tab(:roles, icon: 'users') %>
    <% end %>
  HTML
end
