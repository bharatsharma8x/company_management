module StripSpacesConcern
  extend ActiveSupport::Concern

  included do
    before_save :remove_extra_spaces
  end

  private

  def remove_extra_spaces
    attributes.each do |attr, value|
      self[attr].strip! if value.is_a?(String)
    end
  end
end
