require 'spec_helper'

describe package('git-core') do
    it { should be_installed }
end
