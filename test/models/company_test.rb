require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  def setup
    @company = companies(:new_painting)
  end
  
  test "company should be valid without email" do
    assert @company.valid?
  end

  test "company should not be valid with email having other domains" do
    @company.email = "new_painting@new_painting.com"
    assert_not @company.valid?
    assert_equal "Email should end with @getmainstreet.com", @company.errors.full_messages.join(", ")
  end
  
  test "company should be valid with getmainstreet email domain" do
    @company.email = "new_painting@getmainstreet.com"
    assert @company.valid?
  end

end
