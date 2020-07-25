class Company < ApplicationRecord
  ALLOWED_DOMAIN_NAMES = ['getmainstreet.com']
  
  has_rich_text :description

  validates :domain,
    inclusion: {
      in: ALLOWED_DOMAIN_NAMES,
      message: I18n.t('error.email', domains: ALLOWED_DOMAIN_NAMES.join(', '))
    }, if: -> { email.present? }
  validate :valid_zip_code, if: -> { zip_code_changed? }, if: -> {:new_record?}
  before_save :update_city_state, if: -> { zip_code_changed? }, if: -> {:new_record?}

  private

  def update_city_state
    zip_code_info = ZipCodes.identify(zip_code)
    self.city = zip_code_info[:city]
    self.state = zip_code_info[:state_code]
  end

  def domain
    EmailUtility.get_domain(email)
  end

  def valid_zip_code
    return if ZipCodes.identify(zip_code)
    errors.add(:zip_code, :invalid, message: I18n.t('error.zip_code'))
  end

end
