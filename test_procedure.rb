require 'date'
require 'arbetsformedlingen'

include Arbetsformedlingen

customer_id = ARGV.shift || fail(ArgumentError, 'missing argument customer_id')
email       = ARGV.shift || fail(ArgumentError, 'missing argument email')

document = Document.new(customer_id: customer_id, email: email)

company = Company.new(
  name: 'ACME AB',
  cin: 'XXYYZZXXYY',
  description: 'A company description',
  address: {
    country_code: 'SE',
    zip: '11356',
    municipality: 'Stockholm',
    street: 'Birger Jarlsgatan 57',
    city: 'Stockholm'
  }
)

publication = Publication.new(
  publish_at_date: Date.today,
  name: 'John Doe',
  email: 'john@example.com'
)

application_method = ApplicationMethod.new(
  external: true, # applications are not made through AF
  url: 'https://app.justarrived.se/jobs',
  summary: 'Goto our website, register or login and then apply.'
)

default_salary = Salary.new(
  currency: 'SEK',
  type: :fixed, # :fixed, :fixed_and_commission, :commission
  summary: 'Your salary will be fixed.'
)

default_qualifications = [Qualification.new(
  summary: 'No previous experience required',
  required: true,
  experience: false,
  # drivers_license: 'B,C1',
  # car: true
)]

# # # # # # # # # # # #
#    TEST PROCEDURE   #
# # # # # # # # # # # #

# Insert
#
# 1. Post one file that contains a posting that is to be classified as:
#    Full time
#    Temporary employment 6 months or longer 
#   In any location in Sweden 
#

schedule = Schedule.new(
  summary: 'Full time job for just over 6 months',
  full_time: true,
  start_date: Date.new(2017, 5, 20),
  end_date: Date.new(2017, 11, 30)
)

position = Position.new(
  company: company,
  schedule: schedule,
  salary: default_salary,
  qualifications: default_qualifications,
  application_method: application_method,
  attributes: {
    address: {
      country_code: 'SE',
      zip: '11356',
      municipality: 'Stockholm',
      street: 'Birger Jarlsgatan 57',
      city: 'Stockholm'
    },
    title: 'This is a test ad for #1',
    purpose: <<-PURPOSE
      Full time
       Temporary employment 6 months or longer 
      In any location in Sweden
    PURPOSE
  }
)

packet = Packet.new(
  publication: publication,
  document: document,
  position: position,
  attributes: {
    active: true,
    job_id: 'test-case-1',
    number_to_fill: 1,
    ssyk_id: '4896'
  }
)

# 2. Post one file that contains a posting that is to be classified as:
#    Part time
#    Permanent 
#   In any location in Sweden
#

schedule = Schedule.new(
  summary: 'Part time job',
  full_time: false,
  start_date: Date.new(2017, 5, 20)
)

position = Position.new(
  company: company,
  schedule: schedule,
  salary: default_salary,
  qualifications: default_qualifications,
  application_method: application_method,
  attributes: {
    address: {
      country_code: 'SE',
      zip: '11356',
      municipality: 'Stockholm',
      street: 'Birger Jarlsgatan 57',
      city: 'Stockholm'
    },
    title: 'This is a test ad for #2',
    purpose: <<-PURPOSE
      Part time
      Permanent 
      In any location in Sweden
    PURPOSE
  }
)

packet = Packet.new(
  publication: publication,
  document: document,
  position: position,
  attributes: {
    active: true,
    job_id: 'test-case-2',
    number_to_fill: 1,
    ssyk_id: '4896'
  }
)

# 3. Post one file that contains a posting that is to be classified as:
#    Full time
#    Temporary employment 11 days to 3 months 
#   In any location in Sweden
#

schedule = Schedule.new(
  summary: 'Part time job',
  full_time: true,
  start_date: Date.new(2017, 5, 20),
  end_date: Date.new(2017, 6, 20)
)

position = Position.new(
  company: company,
  schedule: schedule,
  salary: default_salary,
  qualifications: default_qualifications,
  application_method: application_method,
  attributes: {
    address: {
      country_code: 'SE',
      zip: '11356',
      municipality: 'Stockholm',
      street: 'Birger Jarlsgatan 57',
      city: 'Stockholm'
    },
    title: 'This is a test ad for #3',
    purpose: <<-PURPOSE
      Full time
       Temporary employment 11 days to 3 months 
      In any location in Sweden
    PURPOSE
  }
)

packet = Packet.new(
  publication: publication,
  document: document,
  position: position,
  attributes: {
    active: true,
    job_id: 'test-case-3',
    number_to_fill: 1,
    ssyk_id: '4896'
  }
)

# 4. Post one file that contains a posting that is to be classified as:
#    Part time
#    Temporary employment 3-6 months 
#   In any location in Sweden
#    Comission only
#

schedule = Schedule.new(
  summary: 'Part time job',
  full_time: false,
  start_date: Date.new(2017, 5, 20),
  end_date: Date.new(2017, 9, 20)
)

salary = Salary.new(
  currency: 'SEK',
  type: :commission, # :fixed, :fixed_and_commission, :commission
  summary: 'Your salary will be commission only.'
)

position = Position.new(
  company: company,
  schedule: schedule,
  salary: salary,
  qualifications: default_qualifications,
  application_method: application_method,
  attributes: {
    address: {
      country_code: 'SE',
      zip: '11356',
      municipality: 'Stockholm',
      street: 'Birger Jarlsgatan 57',
      city: 'Stockholm'
    },
    title: 'This is a test ad for #4',
    purpose: <<-PURPOSE
       Temporary employment 3-6 months 
      In any location in Sweden
       Comission only
    PURPOSE
  }
)

packet = Packet.new(
  publication: publication,
  document: document,
  position: position,
  attributes: {
    active: true,
    job_id: 'test-case-4',
    number_to_fill: 1,
    ssyk_id: '4896'
  }
)

# 5. Post one file that contains a posting that is to be classified as:
#    Full time
#    Temporary employment during the summer months (June to August) 
#   In any location in Sweden
#    Fixed plus Comission
#

schedule = Schedule.new(
  summary: 'Full time job',
  full_time: true,
  start_date: Date.new(2017, 6, 1),
  end_date: Date.new(2017, 8, 31)
)

salary = Salary.new(
  currency: 'SEK',
  type: :fixed_and_commission, # :fixed, :fixed_and_commission, :commission
  summary: 'Your salary will be fixed and with commission.'
)

position = Position.new(
  company: company,
  schedule: schedule,
  salary: salary,
  qualifications: default_qualifications,
  application_method: application_method,
  attributes: {
    address: {
      country_code: 'SE',
      zip: '11356',
      municipality: 'Stockholm',
      street: 'Birger Jarlsgatan 57',
      city: 'Stockholm'
    },
    title: 'This is a test ad for #4',
    purpose: <<-PURPOSE
      Temporary employment during the summer months (June to August) 
      In any location in Sweden
      Fixed plus Comission
    PURPOSE
  }
)

packet = Packet.new(
  publication: publication,
  document: document,
  position: position,
  attributes: {
    active: true,
    job_id: 'test-case-5',
    number_to_fill: 1,
    ssyk_id: '4896'
  }
)

# 6. Post one file that contains a posting that is to be classified as:
#    Full time
#    Temporary employment 
#   Unspecified workplace within Sweden
#


# 7. Post one file that contains a posting that is to be classified as:
#    Full time
#    Permanent
#    Any country outside of Sweden
#    Fixed salary
#


# 8. Post one file that contains a posting that is to be classified as:
#    Full time
#    Temporary employment 6 months or longer 
#   In any location in Sweden 
#   Driver license, CE 
#   Occupation truck driver 
#   Fixed plus Comission

schedule = Schedule.new(
  summary: 'Full time job',
  full_time: true,
  start_date: Date.new(2017, 5, 15),
  end_date: Date.new(2017, 12, 20)
)

qualifications = [Qualification.new(
  summary: 'No previous experience required',
  required: true,
  experience: false,
  drivers_license: 'CE'
)]

salary = Salary.new(
  currency: 'SEK',
  type: :fixed_and_commission, # :fixed, :fixed_and_commission, :commission
  summary: 'Your salary will be fixed and with commission.'
)

position = Position.new(
  company: company,
  schedule: schedule,
  salary: salary,
  qualifications: qualifications,
  application_method: application_method,
  attributes: {
    address: {
      country_code: 'SE',
      zip: '11356',
      municipality: 'Stockholm',
      street: 'Birger Jarlsgatan 57',
      city: 'Stockholm'
    },
    title: 'This is a test ad for #8',
    purpose: <<-PURPOSE
    Full time
      Temporary employment 6 months or longer 
      In any location in Sweden 
      Driver license, CE 
      Occupation truck driver 
      Fixed plus Comission
    PURPOSE
  }
)

packet = Packet.new(
  publication: publication,
  document: document,
  position: position,
  attributes: {
    active: true,
    job_id: 'test-case-8',
    number_to_fill: 1,
    ssyk_id: '7535' # truck driver
  }
)
