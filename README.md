# Arbetsförmedlingen [![Build Status](https://travis-ci.org/buren/arbetsformedlingen.svg?branch=master)](https://travis-ci.org/buren/arbetsformedlingen) [![Gem Version](https://badge.fury.io/rb/arbetsformedlingen.svg)](https://badge.fury.io/rb/arbetsformedlingen)

Arbetsförmedlingen API client (Swedish Public Employment Service).

__Features__
* Post job ad (a.k.a Direktöverförda annonser)
* Platsannons API Client
* WSOccupation SOAP API Client


__Index__
* [Installation](#installation)
* [API Client](#api-client)
* [Post job ad](#post-job-ad)
* [WSOccupation API Client](#wsoccupation-api-client)
* [RDoc](http://www.rubydoc.info/gems/arbetsformedlingen/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arbetsformedlingen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arbetsformedlingen

## API Client

__Create a client:__

```ruby
client = Arbetsformedlingen::API::Client.new(locale: 'en')
```

__Fetch all ads containing specified keyword:__
```ruby
ads = client.ads(keywords: 'ruby')
ads.map(&:title)
```

__Fetch one ad:__
```ruby
ad = client.ad(id: 7408089)
ad.title
ad.occupation
ad.application.last_application_at
```

__Fetch countries in area:__
```ruby
countries = client.countries(area_id: 2)
countries.map do |country|
  "#{country.name} has #{country.total_vacancies} total vacancies."
end
```

## Post job ad

__Complete example creating a packet__

:information_source: There is quite a lot of data you can/must send to the API when creating an ad.

```ruby
require 'date'
require 'arbetsformedlingen'

include Arbetsformedlingen # just for brevity

document = Document.new(
  customer_id: 'XXXYYYZZZ',
  email: 'a@example.com'
)

company = Company.new(
  name: 'ACME AB',
  cin: 'XXYYZZXXYY',
  description: 'A company description',
  address: {
    country_code: 'SE',
    zip: '11356',
    municipality: 'Stockholm',
    street: 'Birger Jarlsgatan 57',
    city: 'stockholm'
  }
)

publication = Publication.new(
  publish_at_date: Date.today,
  name: 'John Doe',
  email: 'john@example.com'
)

schedule = Schedule.new(
  full_time: false,
  summary: '3 days a week 8.00-17.00',
  start_date: Date.today,
  end_date: nil
)

salary = Salary.new(
  currency: 'SEK',
  type: :fixed, # :fixed, :fixed_and_commission, :commission
  summary: 'Your salary will be...'
)

qualifications = []
qualifications << Qualification.new(
  summary: 'A summary', # optional, but recommended field
  required: true,
  experience: true,
  drivers_license: 'B,C1',
  car: true
)

qualifications << Qualification.new(
  summary: 'A summary', # optional, but recommended field
  required: false
)

application_method = ApplicationMethod.new(
  external: true, # applications are not made through AF
  url: 'https://example.com',
  summary: 'Goto our website'
)

position = Position.new(
  company: company,
  schedule: schedule,
  salary: salary,
  qualifications: qualifications,
  application_method: application_method,
  attributes: {
    title: 'A title',
    purpose: 'A purpose',
    address: {
      country_code: 'SE',
      zip: '11356',
      municipality: 'Stockholm',
      street: 'Birger Jarlsgatan 57',
      city: 'stockholm'
    }
  }
)

packet = Packet.new(
  publication: publication,
  document: document,
  position: position,
  attributes: {
    active: true,
    job_id: 1,
    number_to_fill: 1,
    occupation: '4896'
  }
)

puts "salary.valid?: #{salary.valid?}"
puts "schedule.valid?: #{schedule.valid?}"
puts "publication.valid?: #{publication.valid?}"
puts "document.valid?: #{document.valid?}"
puts "company.valid?: #{company.valid?}"
puts "application_method.valid?: #{application_method.valid?}"
puts "position.valid?: #{position.valid?}"
puts "packet.valid?: #{packet.valid?}"

client = API::Client.new(locale: 'sv')
client.create_ad(packet)
```

## WSOccupation API Client

There is some support for Arbetsförmedlingen's `WSOccupation` SOAP API. See [PR#3](https://github.com/buren/arbetsformedlingen/pull/3).

```ruby
client = Arbetsformedlingen::API::WSOccupationClient.new
response = client.occupations
response.xml.css('Name').first.text
# => "Landskapsarkitekter och landskapsingenjörer"
```

[WSOccupationClient documentation](http://www.rubydoc.info/gems/arbetsformedlingen/Arbetsformedlingen/API/WSOccupationClient).

## Notes

__Arbetsförmedlingen TaxonomyService__

Some requests had to be made to Arbetsförmedlingens TaxonomyService in order to fetch the data for the occupation codes. You can find that (plus some more) here :point_down: Postman.

[![Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/9a27ec2518c1005f8aea)

## Terms translation table

This gem has translated the attribute names in Arbetsförmedlingens (AF) API from Swedish to English. You can find the translations below.

| Arbetsförmedlingen Term | Gem term           |
|------------------------ |--------------------|
| landområde/värdsdel | areas |
| kommun | municipality |
| län | counties |
| län2 | counties2 |
| yrkesområde | occupational_fields |
| yrkesgrupp | occupational_group |
| yrkesgrupp | occupational_group |
| yrkesnamn | occupation |


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/buren/arbetsformedlingen.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
