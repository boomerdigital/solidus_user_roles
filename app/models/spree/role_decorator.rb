Spree::Role.class_eval do
  has_many :role_permissions, dependent: :destroy
  has_many :permission_sets, through: :role_permissions

  scope :non_base_roles, -> { where.not(name: ['admin', 'user']) }
  validates :name, uniqueness: true
  after_save :assign_permissions

  def permission_sets_constantized
    permission_sets.map(&:set).map { |set_class_name|
      begin
        set_class_name.constantize
      rescue NameError
        nil
      end
    }.compact
  end

  def assign_permissions
    if SolidusSupport.solidus_gem_version < Gem::Version.new('2.5.x')
      Spree::RoleConfiguration.configure do |config|
        config.assign_permissions name, permission_sets_constantized
      end
    else
      Spree::Config.roles.assign_permissions name, permission_sets_constantized
    end
  end
end
