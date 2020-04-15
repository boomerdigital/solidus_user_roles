require 'spec_helper'

describe Spree::RolePermission, type: :model do
  it { should belong_to :role }
  it { should belong_to :permission_set }
end
