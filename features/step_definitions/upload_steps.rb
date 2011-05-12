Given /^I have uploaded "([^"]*)"$/ do |filename|
  When %%I upload "#{filename}"%
end

When /^I upload "([^"]*)"$/ do |filename|
  Given %%I am on the new upload page%
  When  %%I attach the file "#{filename}" to "Ofx file"%
  And   %%I press "Upload"%
end

Then /^I should see that (\d+) transactions were imported$/ do |imported|
  assert page.has_css?('#flash', :text => /#{imported} transactions were imported/)
end

Then /^I should see that there were (\d+) duplicates$/ do |duplicates|
  assert page.has_css?('#flash', :text => /#{duplicates} duplicate transactions/)
end