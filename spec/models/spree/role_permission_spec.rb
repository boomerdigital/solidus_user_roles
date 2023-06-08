require 'spec_helper'

describe Spree::RolePermission, type: :model do
  it { is_expected.to belong_to :role }
  it { is_expected.to belong_to :permission_set }
end
