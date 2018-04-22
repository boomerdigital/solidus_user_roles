Spree::Role.class_eval do
  has_many :role_permissions, dependent: :destroy
  has_many :permission_sets, through: :role_permissions

  scope :non_base_roles, -> { where.not(name: ['admin', 'user']) }
  validates :name, uniqueness: true
  after_save :assign_permissions

  def permission_sets_constantized
    permission_sets.map(&:set).map(&:constantize)
  end

  def assign_permissions
    Spree::Config.roles.assign_permissions name, permission_sets_constantized
  end
end
