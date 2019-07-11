Given("the following data for a contact") do |table|
  @contact = Contact.new(table.rows_hash)
end

Given("an existing contact with the values") do |table|
  @contact = Contact.new(table.rows_hash)
  @contact.save!
end

Given("an existing contact") do
  @contact = Contact.new(first_name: 'Linus', last_name: 'Torvalds', cell_phone: "1234567", zip_code: "12345")
  @contact.save!
end

When("I save the values into a Contact") do
  begin
    @contact.save!
  rescue => e
    @error = e
  end
end

When("I update contact with the values") do |table|
  @contact.update table.rows_hash
  @contact.save!
end

When("I delete the contact") do
  @contact.destroy!
end

Then("contact object should be saved") do
  Contact.find(id: @contact.id.to_s) # raise an error if not found
end

Then(/I should receive the '(.*)' error message/) do |expected|
  got = @error.summary
  fail "Error message not found. Got #{got}. Expected #{expected}" unless got.include? expected
end

Then("the contact should be have") do |table|
  @contact.reload
  expected = table.rows_hash
  not_found = []
  expected.each_pair do |field, value|
    not_found << field unless "#{@contact.send(field)}" == value
  end
  fail "Value/s not found #{not_found}" if not_found.any?
end