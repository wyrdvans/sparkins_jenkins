context = ChefDK::ProvisioningData.context

# Set the port dynamically via the command line:
target_port = context.opts.port

with_driver 'vagrant:~/.vagrant.d/boxes' do

  options = {
    vagrant_options: {
      'vm.box' => 'opscode-ubuntu-14.04',
      'vm.network' => ":forwarded_port, guest: 8080, host: #{target_port}"
    },
    convergence_options: context.convergence_options
  }


  machine context.node_name do
    machine_options(options)

    # This forces a chef run every time, which is sensible for `chef provision`
    # use cases.
    converge(true)
    action(context.action)
  end
end
