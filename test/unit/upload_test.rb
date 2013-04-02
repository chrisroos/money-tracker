require 'test_helper'

class UploadTest < ActiveSupport::TestCase
  test "should be valid when built from the factory" do
    upload = FactoryGirl.build(:upload)
    assert upload.valid?
  end

  test "should be invalid without a file" do
    upload = FactoryGirl.build(:upload, ofx_file: nil)
    assert !upload.valid?
  end
end