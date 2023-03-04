# Integration tests for mongodb::default recipe

describe package('mongodb-org') do
  it { should be_installed }
end

describe service('mongod') do
  it { should be_enabled }
  it { should be_running }
end
