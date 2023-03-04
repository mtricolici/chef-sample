# Integration tests for errbit::default recipe

describe user('errbit') do
  it { should exist }
  its('home') { should eq '/errbit' }
end

['/errbit', '/errbit/sources'].each do |path|
  describe file(path) do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'errbit' }
  end
end

['/errbit/.rvm/bin/rvm', '/errbit/.rvm/rubies/ruby-2.7.6/bin/ruby'].each do |path|
  describe file(path) do
      it { should exist }
      it { should be_file }
      it { should be_executable }
      it { should be_owned_by 'errbit' }
  end
end

describe service('errbit') do
  it { should be_enabled }
  it { should be_running }
end

describe port(3000) do
  it { should be_listening }
  its('protocols') { should include('tcp') }
  its('processes') { should include 'ruby' }
end
