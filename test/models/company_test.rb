require 'test_helper'

class CompanyTest < ActiveSupport::TestCase

  test 'it should allow blank email' do
    assert companies(:thompson_patining).valid?
  end

  test 'it should throw error for invalid email domain' do
    assert_not companies(:marcus_painting).valid?
    assert_includes companies(:marcus_painting).errors.full_messages, 'Domain Invalid! Allowed domains are getmainstreet.com'
  end

  test 'it should validate email domain' do
    assert companies(:hometown_painting).valid?
  end

  test 'it should throw error for blank zipcode' do
    assert_not companies(:armstrong_painting).valid?
    assert_includes companies(:armstrong_painting).errors.full_messages, "Zip code has to be a valid 5 digit US zip code."
  end

  test 'it should throw error for invalid zipcode' do
    assert_not companies(:wolf_painting).valid?
    assert_includes companies(:wolf_painting).errors.full_messages, "Zip code has to be a valid 5 digit US zip code."
  end

  test 'it should verify if city and state is saved for correct zipcode' do
    company = companies(:brown_painting)
    company.save
    assert_equal company.city, 'Nashville'
    assert_equal company.state, 'TN'
  end
end