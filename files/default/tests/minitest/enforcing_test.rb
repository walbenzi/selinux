require File.expand_path('../support/helpers', __FILE__)

describe 'selinux::default' do

  include Helpers::Selinux

  # Example spec tests can be found at http://git.io/Fahwsw

  #Check Current State
  it "Check the current state of SELinux" do
    if node['force_reboot_if_needed'] == "true"
      result = assert_sh("getenforce")
      assert_includes result, "Enforcing"
    else
      puts "force reboot is not set, so current state cannot be guaranteed"
    end
  end

  #Check Next Boot configuration
  it 'Verifies selinux is enabled in /etc/selinux/config' do
    file('/etc/selinux/config').must_match /^SELINUX=enforcing$/
    file('/etc/selinux/config').must_match /^SELINUXTYPE=targeted$/
  end

end
