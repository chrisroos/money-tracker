require 'test_helper'

class UploadTest < ActiveSupport::TestCase

  should "be valid when built from the factory" do
    upload = Factory.build(:upload)
    assert upload.valid?
  end

  should "be invalid without a file" do
    upload = Factory.build(:upload, :ofx_file => nil)
    assert !upload.valid?
  end

end