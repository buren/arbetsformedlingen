# Arbetsförmedlingen [![Build Status](https://travis-ci.org/buren/arbetsformedlingen.svg?branch=master)](https://travis-ci.org/buren/arbetsformedlingen) [![Gem Version](https://badge.fury.io/rb/arbetsformedlingen.svg)](https://badge.fury.io/rb/arbetsformedlingen)

Arbetsförmedlingen API client (Swedish Public Employment Service).

__Index__
* [Installation](#installation)
* [Post job ad](#post-job-ad) (a.k.a Direktöverförda annonser)
* [API clients for](#api-clients)
  + [Platsannonser/Platsbanken](#api-clients)
  * [Ontology](#ontology-api-client)
  * [Taxonomy (SOAP)](#taxonomy-api-client)
  * [WSOccupation (SOAP)](#wsoccupation-api-client)
* [RDoc](http://www.rubydoc.info/gems/arbetsformedlingen/).

## API Clients

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

:warning: In order to post live job ads to Arbetsförmedlingen you need to contact them and go through a test procedure. You can find their own documentation and some additional notes [here](https://goo.gl/c5jtBv).

You can find Arbetsförmedlingens own documentation and some additional notes [here](https://goo.gl/c5jtBv). Note that the documentation provided by Arbetsförmedlingen can be pretty hard to follow.

__Validation support__
All models used to create a job ad include validations. _A lot_ of work was put into finding all the quirks in the API and adding each validation to its corresponding model. I can't recommend using it enough.

__Complete example creating a packet__

There's a lot of data you can/must send to the API when creating an ad. See files in `lib/arbetsformedlingen/models` for details.

[See full example](examples/post_job_ad.rb).

## WSOccupation API Client

```ruby
client = Arbetsformedlingen::API::WSOccupationClient.new
response = client.occupations
response.xml.css('Name').first.text
# => "Landskapsarkitekter och landskapsingenjörer"
```

[`WSOccupationClient` documentation](http://www.rubydoc.info/gems/arbetsformedlingen/Arbetsformedlingen/API/WSOccupationClient).

:link: [Arbetsformedlingen WsOccupation API documentation](https://api.arbetsformedlingen.se/af/v0/Occupation/wsoccupation.asmx)

## Ontology API Client

```ruby
client = Arbetsformedlingen::API::OntologyClient.new
response = client.concepts(filter: 'ruby', type: 'skill')
response.json
# => [{"uuid"=>"035fc466-605e-5684-a106-a458929f27c6", "name"=>"Ruby", "type"=>"skill"}, ...]
```

[`OntologyClient` documentation](http://www.rubydoc.info/gems/arbetsformedlingen/Arbetsformedlingen/API/WSOccupationClient).

:link: [Arbetsformedlingen Ontology API documentation](http://ontologi.arbetsformedlingen.se/ontology/v1/?url=swagger.json#/Ontology)

## Taxonomy API Client

There is some support for Arbetsförmedlingen's `Taxonomi` SOAP API. See [#20](https://github.com/buren/arbetsformedlingen/issues/20).

```ruby
client = Arbetsformedlingen::API::TaxonomyClient.new
response = client.occupation_names(language_id: 502) # sv language id
response.xml.css('OccupationName Term').first.text
# => "1:e Fartygsingenjör/1:e Maskinist"
```

[`TaxonomyClient` documentation](http://www.rubydoc.info/gems/arbetsformedlingen/Arbetsformedlingen/API/WSOccupationClient).

:link: [Arbetsformedlingen TaxonomiService API documentation](http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx)

## Notes

__Arbetsförmedlingen TaxonomyService__

Some requests had to be made to Arbetsförmedlingens TaxonomyService in order to fetch the data for the occupation codes. You can find that (plus some more) here :point_down: Postman.

[![Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/9a27ec2518c1005f8aea)

## Terms translation table

This gem has translated the attribute names in Arbetsförmedlingens (AF) API from Swedish to English. You can find the translations below.

| Arbetsförmedlingen Term | Gem term           |
|------------------------ |--------------------|
| landområde/värdsdel | areas |
| kommun | municipality |
| län | counties |
| län2 | counties2 |
| yrkesområde | occupational_fields |
| yrkesgrupp | occupational_group |
| yrkesgrupp | occupational_group |
| yrkesnamn | occupation |

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arbetsformedlingen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arbetsformedlingen

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/buren/arbetsformedlingen.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
