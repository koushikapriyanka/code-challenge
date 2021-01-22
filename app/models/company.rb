class Company < ApplicationRecord
  has_rich_text :description

  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@getmainstreet\.com\z/,  message: "should end with @getmainstreet.com"  }, allow_blank: true

  before_save :update_city_and_state, if: :zip_code_changed?

  DEFAULT_COLOR = '#28a745'

  def brand_color
    self.color || DEFAULT_COLOR
  end

  private

  def update_city_and_state
  	zip_info = ZipCodes.identify(self.zip_code)
    if zip_info.present?
      self.city = zip_info[:city]
      self.state = zip_info[:state_code]
    else
      self.city = "City"
      self.state = "State"
    end
  end
end
