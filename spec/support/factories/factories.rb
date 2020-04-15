FactoryBot.define do
  factory :permission_set, class: Spree::PermissionSet do
    name { 'ProductManagement' }
    set { 'Spree::PermissionSets::ProductManagement' }
  end
end
