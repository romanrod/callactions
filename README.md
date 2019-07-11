# Exercise

This is the resolution of a test task

## Install and setup

Requirements 

* Ruby 2.6.0 or higher
* MongoDB

Clone repository

```
git clone git@github.com:romanrod/callactions.git
```

Bundle

```
bundle install
```

Run tests

```
rake test
```

Run the App
```
rake start
```

Enjoy!


## Task Definitions

Develop an API with the following resources and properties
### Contacts

- First Name (String)
- Last Name (String)
- Cell Phone (String)
- Zip Code (Number)


### Activities
- Contact ID (Number)
- Description (String)

* All fields must be required
* Todos los registros deben tener los campos create_at y updated_at
* All registers must include `created_at` and `updated_at`

Required endpoints

for Contacts
- GET       /contacts/
- GET       /contacts/:id
- POST      /contacts/
- PUT       /contacts/:id
- DELETE


for Activities
- GET       /contacts/:id/activities
- POST      /contacts/:id/activities
- PUT       /contacts/:id/activities/:id
- DELETE

* Should be coded in Ruby
* Dababase as your choice
* Content type must be "application/json"
