require 'spec_helper'

describe Spree::Role, type: :model do
  let(:role) {
    role = build(:role)
    role.permission_sets << create(:permission_set)
    role
  }

  it { is_expected.to have_many :role_permissions }
  it { is_expected.to have_many(:permission_sets).through(:role_permissions) }
  it { is_expected.to validate_uniqueness_of(:name).ignoring_case_sensitivity }

  describe "#assign_permissions" do
    it 'creates new Spree::RoleConfiguration::Role' do
      expect { role.save }.to change { Spree::Config.roles.roles.count }.by(1)
    end

    it 'updates the existing Spree::RoleConfiguration::Role' do
      role.save
      role.permission_sets << create(:permission_set, name: 'test', set: 'Spree::PermissionSets::ProductDisplay')

      expect { role.save }.to change { Spree::Config.roles.roles[role.name].permission_sets.count }.from(1).to(2)
    end
  end

  describe "#destroy" do
    let(:role) { create(:role) }

    before do
      role.permission_sets << create(:permission_set)
      role.save
    end

    it "destroys all associated role permissions" do
      role_permission = role.role_permissions.first

      role.destroy
      aggregate_failures do
        expect{ described_class.find(role.id) }.to raise_error(ActiveRecord::RecordNotFound)
        expect{ Spree::RolePermission.find(role_permission.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
