# frozen_string_literal: true

namespace :solidus_user_roles do
  desc "Loads seed data."
  task load_seeds: :environment do
    Spree::PermissionSets::Base.subclasses.each do |permission|
      Spree::PermissionSet.find_or_create_by(name: permission.to_s.split('PermissionSets::').last, set: permission.to_s)
    end
  end
end
