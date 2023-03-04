# Integration tests for errbit::default recipe

describe user('errbit') do
  it { should exist }
  its('home') { should eq '/errbit' }
end

describe file('/errbit') do
  it { should exist }
  it { should be_directory }
  it { should be_owned_by 'errbit' }
end
