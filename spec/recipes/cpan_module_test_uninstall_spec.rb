require 'spec_helper'

describe 'cpan_module_test::uninstall' do
  context 'on Ubuntu 12.04' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: 'cpan_module')
                            .converge(described_recipe)
    end
    it 'expects cpan LWRP to run' do
      stub_command("perl -mTest::MockModule -e ';' 2> /dev/null").and_return(true)
      expect(chef_run).to uninstall_cpan_module('Test::MockModule')
    end
    it 'installs Test::MockModule via CPAN' do
      stub_command("perl -mTest::MockModule -e ';' 2> /dev/null").and_return(true)
      expect(chef_run).to run_execute('CPAN :uninstall Test::MockModule')
    end
  end
end
