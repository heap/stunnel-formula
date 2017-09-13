# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/stunnel/stunnel.conf') do
  it { should be_file }
  its(:content) { should match /pid = \/var\/run\/stunnel.pid/ }
  its(:content) { should match /setuid = stunnel4/ }
  its(:content) { should match /setgid = stunnel4/ }
  its(:content) { should match /\[redis\]\s*\naccept = 0.0.0.0:6380\nconnect = 127.0.0.1:6379/ }
end

describe file('/etc/default/stunnel4') do
  it { should be_file }
  its(:content) { should match /ENABLED=1/ }
  its(:content) { should match /FILES="\/etc\/stunnel\/\*\.conf/ }
end
