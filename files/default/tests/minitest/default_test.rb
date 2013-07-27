require File.expand_path('../support/helpers', __FILE__)

describe 'selinux::default' do

  include Helpers::Selinux

  # Example spec tests can be found at http://git.io/Fahwsw

  #Check Current State

  #Check Next Boot configuration
  it 'Verifies selinux is disabled in /etc/selinux/config' do
    file('/etc/selinux/config').must_match /^SELINUX=disabled$/
    file('/etc/selinux/config').must_match /^SELINUXTYPE=targeted$/
  end

end
