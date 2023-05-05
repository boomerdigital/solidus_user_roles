require 'spec_helper'

describe Spree::PermissionSet, type: :model do
  it { is_expected.to have_many :role_permissions }
  it { is_expected.to have_many(:roles).through(:role_permissions) }
  it { is_expected.to validate_presence_of :name }
end
