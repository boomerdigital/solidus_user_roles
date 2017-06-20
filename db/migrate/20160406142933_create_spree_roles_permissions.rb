class CreateSpreeRolesPermissions < SolidusSupport::Migration[4.2]
  def change
    create_table :spree_role_permissions do |t|
      t.references :role
      t.references :permission_set
      t.timestamps null: false
    end
  end
end
