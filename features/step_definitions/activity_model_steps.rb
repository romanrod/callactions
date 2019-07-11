Given("with some activities added") do
  @activity = Activity.new(description: 'some description', contact_id: @contact.id.to_s)
  @activity.save!
end

Given("with the following activity") do |string|
  @activity = Activity.new(description: string, contact_id: @contact.id.to_s)
  @activity.save!
end


When("I add the following description to that contact") do |text|
  @activity = Activity.new(description: text, contact_id: @contact.id.to_s)
  @activity.save!
end

When("I edit the activity description with") do |string|
  @new_description = string
  @activity.update(description: @new_description)
  @activity.save!
end

Then("I should see the activity added to contact") do
  fail "Activity not found in contact" unless Contact.find(@contact).has_activity? @activity
end

Then("the contact shouldn't exist any more") do
  fail "Contact already exists after deletion" unless Contact.count.zero?
end

Then("no activities should be present") do
  fail "related activity to contact not deleted when contact deleted" unless Activity.count.zero?
end

Then("the activity should be updated") do
  @activity.reload
  got = @activity.description
  fail "Acvtivity not updated. Got #{got}. Expected #{@new_description}" unless got == @new_description
end