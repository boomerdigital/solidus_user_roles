require 'spec_helper'

describe Spree::Role, type: :model do
  it { should have_many :role_permissions }
  it { should have_many(:permission_sets).through(:role_permissions) }
  it { should validate_uniqueness_of :name }
  let(:role) {
    role = build(:role)
    role.permission_sets << create(:permission_set)
    role
  }

  context "#permission_sets_constantized" do
    context "when a permission set does not exist" do
      let(:role) {
        role = create(:role)
        role.permission_sets = [permission_set, ghost_permission_set]
        role
      }
      let(:permission_set) { create(:permission_set) }
      let(:ghost_permission_set) {
        create(:permission_set, name: 'WidgetDisplay', set: 'Spree::PermissionSets::WidgetDisplay')
      }

      it 'returns the remaining permission set classes' do
        expect(role.permission_sets_constantized.count).to eq(1)
      end
    end

  end

  context "#assign_permissions" do
    it 'creates new Spree::RoleConfiguration::Role' do
      if SolidusSupport.solidus_gem_version < Gem::Version.new('2.5.x')
        expect { role.save }.to change { Spree::RoleConfiguration.instance.roles.count }.by(1)
      else
        expect { role.save }.to change { Spree::Config.roles.roles.count }.by(1)
      end
    end
    it 'updates the existing Spree::RoleConfiguration::Role' do
      role.save
      role.permission_sets << create(:permission_set, name: 'test', set: 'Spree::PermissionSets::ProductDisplay')

      if SolidusSupport.solidus_gem_version < Gem::Version.new('2.5.x')
        expect { role.save }.to change { Spree::RoleConfiguration.instance.roles[role.name].permission_sets.count }.from(1).to(2)
      else
        expect { role.save }.to change { Spree::Config.roles.roles[role.name].permission_sets.count }.from(1).to(2)
      end
    end
  end

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
