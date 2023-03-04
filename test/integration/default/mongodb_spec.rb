# Integration tests for mongodb::default recipe

describe package('mongodb-org') do
  it { should be_installed }
end

describe service('mongod') do
  it { should be_enabled }
  it { should be_running }
end

describe port(27017) do
  it { should be_listening }
  its('protocols') { should include('tcp') }
  its('processes') { should include 'mongod' }
end
