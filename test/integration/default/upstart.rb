if os[:family] == 'debian' && os[:release] == '14.04'
  describe file('/etc/init/stunnel.conf') do
    it { should be_file }
    its(:content) { should match /limit nofile 4096 4096/ }
  end
end

if os[:family] == 'debian' && os[:release] == '16.04'
  describe file('/etc/systemd/system/stunnel.service') do
    it { should be_file }
    its(:content) { should match /LimitNOFILE=4096/ }
  end
end
