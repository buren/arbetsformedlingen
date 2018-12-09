# frozen_string_literal: true

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
  publish_at: Date.today,
  unpublish_at: Date.today + 21,
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
