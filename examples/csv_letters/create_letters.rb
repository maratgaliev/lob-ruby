$:.unshift File.expand_path("../../lib", File.dirname(__FILE__))
require 'lob'
require 'csv'

# Initialize Lob object
Lob.api_key = 'test_799ff27291c166d10ba191902ad02fb059c'
@lob = Lob.load

# Load the HTML from letter_template.html
letter_html = File.open(File.expand_path('../letter_template.html', __FILE__)).read

# Parse the CSV and create the letters.
CSV.foreach(File.expand_path('../input.csv', __FILE__)) do |row|
  letter = @lob.letters.create(
    description: 'CSV Test',
    to: {
      name: row[0],
      address_line1: row[1],
      address_line2: row[2],
      address_city: row[3],
      address_state: row[4],
      address_zip: row[5],
      address_country: row[6]
    },
    from: {
      name: 'Lob',
      address_line1: '123 Main Street',
      address_city: 'San Francisco',
      address_state: 'CA',
      address_zip: '94185',
      address_country: 'US'
    },
    file: letter_html,
    data: {
      name: row[0],
      city: row[3]
    },
    color: false
  )
  puts letter['url']
end
