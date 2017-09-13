# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/stunnel/stunnel.conf') do
  it { should be_file }
  its(:content) { should match /pid = \/var\/run\/stunnel.pid/ }
  its(:content) { should match /\[redis\]\nclient = yes\naccept = 0.0.0.0:6380\nconnect = 127.0.0.1:6379/ }
end


