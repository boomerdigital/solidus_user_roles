require 'spec_helper'

describe Spree::PermissionSet, type: :model do
  it { should have_many :role_permissions }
  it { should have_many(:roles).through(:role_permissions) }
  it { should validate_presence_of :name }
end
