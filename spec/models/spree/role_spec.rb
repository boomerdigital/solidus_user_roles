require 'spec_helper'

describe Spree::Role, type: :model do
  it { should have_many :role_permissions }
  it { should have_many(:permission_sets).through(:role_permissions) }
  it { should validate_uniqueness_of :name }

  context "#destroy" do
    before do
       @role = create(:role)
       @role.permission_sets << create(:permission_set)
       @role.save
       @role_permission = @role.role_permissions.first
    end

    it "should destroy all associated role permissions" do
      @role.destroy
      expect{ Spree::Role.find(@role.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect{ Spree::RolePermission.find(@role_permission.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
