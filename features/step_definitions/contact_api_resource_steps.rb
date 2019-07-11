Given("the following body") do |string|
  @body = JSON.parse(string)
end

Given("an existing contact on \/contacts") do |string|
  @body = JSON.parse(string)
  step "I post it to contacts"
end

When("I post it to contacts") do
  post 'v1/contacts', @body.to_json, content_type
  @contact_id = parsed_response["id"]
end

When("I put contact with the body") do |string|
  @update_body = JSON.parse(string)
  put "v1/contacts/#{@contact_id}", @update_body.to_json, content_type
end

Then("I should receive {int} OK") do |int|
  got = last_response.status
  fail "Response isn't as expected. Got #{got}" unless got == int
end

Then(/I should receive (\d+) with the '(.*)' on response/) do |int, string|
  fail "Status code isn't #{int}" unless last_response.status == int
  received_message = JSON.parse(last_response.body)['message']
  fail "Error message doesn't contain expected text" unless received_message.include? string
end

Then("the contact resource should be have") do |string|
  get "v1/contacts/#{@contact_id}"
  expected = JSON.parse(string)
  not_found = []
  expected.each_pair do |field, value|
    not_found << field unless "#{parsed_response[field]}" == value
  end
  fail "Following fields not found as expected #{not_found}" unless not_found.empty?
end