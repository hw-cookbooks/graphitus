require 'serverspec'
require 'uri'
require 'net/http'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe 'Apache2' do
  it 'is listening on port 8081' do
    expect(port(8081)).to be_listening
  end

  it 'web port responds as a graphitus site' do
    uri = URI('http://127.0.0.1:8081')
    response = Net::HTTP.get_response(uri)
    js = Regexp.escape(%(href="css/graphitus.css"))
    expect(response.body).to match(Regexp.new(js))
  end
end
