Given /^I have uploaded "([^"]*)"$/ do |filename|
  When %%I upload "#{filename}"%
end

When /^I upload "([^"]*)"$/ do |filename|
  Given %%I am on the new upload page%
  When  %%I attach the file "#{filename}" to "Ofx file"%
  And   %%I press "Upload"%
end