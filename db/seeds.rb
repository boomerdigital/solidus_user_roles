# frozen_string_literal: true

Spree::PermissionSets::Base.subclasses.each do |permission|
  Spree::PermissionSet.create(name: permission.to_s.split('PermissionSets::').last, set: permission.to_s)
end
