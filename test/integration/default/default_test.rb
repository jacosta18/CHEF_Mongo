# InSpec test for recipe mongo::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
end

describe package "mongodb-org" do
  it { should be_installed }
  # it { should be_installed.with_version('3.x.x') }
  #its ('version'){should match /3\./}
  it { should be_enabled}
end
