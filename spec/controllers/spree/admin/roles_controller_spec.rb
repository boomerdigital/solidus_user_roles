require 'spec_helper'

describe Spree::Admin::RolesController do
  stub_authorization!
  let(:role) { create(:role) }
  let(:permission_set) { create(:permission_set) }

  describe "#index" do
    subject { get :index }

    it { is_expected.to be_successful }
  end

  describe "#new" do
    subject { get :new }

    it { is_expected.to be_successful }
  end

  describe "#edit" do
    subject { get :edit, params: { id: role.id } }

    it { is_expected.to be_successful }
  end

  describe "#create" do
    let(:params) do
      {
        role: {
          name: "TEST #{rand(10000)}",
          permission_set_ids: [permission_set.id]
        }
      }
    end

    subject { post :create, params: params }
    it { is_expected.to redirect_to(spree.admin_roles_path) }

    it "expect @role to eq the role being updated" do
      expect(assigns(:role)).to eq(@role)
    end

    it "should update the permission sets" do
      expect{subject}.to change { Spree::Role.count }.by(1)
    end
    it "should update the RoleConfiguration" do
      if SolidusSupport.solidus_gem_version < Gem::Version.new('2.5.x')
        expect{subject}.to change {Spree::RoleConfiguration.instance.roles.count}.by(1)
      else
        expect{subject}.to change {Spree::Config.roles.roles.count}.by(1)
      end
    end
  end

  describe "#update" do
    let(:params) do
      {
        id: role.to_param,
        role: {
          name: role.name,
          permission_set_ids: [permission_set.id]
        }
      }
    end

    subject { put :update, params: params }
    it { is_expected.to redirect_to(spree.admin_roles_path) }

    it "expect @role to eq the role being updated" do
      expect(assigns(:role)).to eq(@role)
    end

    it "should update the permission sets" do
      expect{subject}.to change { role.reload.permission_sets.count }.by(1)
    end
  end

  describe "#destroy" do
    subject { put :destroy, params: { :id => role.to_param } }
    it { is_expected.to have_http_status(302) }
  end
end
