require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text "City, State"
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "93009", @company.zip_code
  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "93003")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "93003", last_company.zip_code
  end

  test "destroy company" do
    visit company_path(@company)

    company_count = Company.count
    @company.destroy
    assert_equal company_count - 1, Company.count
  end

  test "update city state when zipcode changes" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_zip_code", with: "93002")
      click_button "Update Company"
    end

    assert_text "Changes Saved"
    zip_data = ZipCodes.identify('93002')
    @company.reload
    assert_equal "93002", @company.zip_code
    assert_equal zip_data[:city], @company.city
    assert_equal zip_data[:state_code], @company.state
  end

  test "update with wrong zipcode" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_zip_code", with: "WRONG ZIP CODE")
      click_button "Update Company"
    end

    assert_text "has to be a valid 5 digit US zip code."
  end

end
