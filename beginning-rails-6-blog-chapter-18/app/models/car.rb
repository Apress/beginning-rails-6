class Car
  include ActiveModel::Dirty
  include ActiveModel::Model

  attr_accessor :make, :model, :year, :color

  validates :make, :model, :year, :color, presence: true
  validates :year, numericality: { only_integer: true, greater_than: 1885, less_than: Time.zone.now.year.to_i + 1 }

  define_attribute_methods :color
  define_model_callbacks :paint

  before_paint :keep_it_waxed
  after_paint :notify_dmv, if: :color_changed?

  def paint(new_color)
    run_callbacks :paint do
      Rails.logger.info "Painting the car #{new_color}"

      color_will_change! if color != new_color
      self.color = new_color
    end
  end

  private

  def keep_it_waxed
    Rails.logger.warn "Be sure to keep your new paint job waxed!"
  end

  def notify_dmv
    Rails.logger.warn "Be sure to notify the DMV about this color change!"
    changes_applied
  end
end
