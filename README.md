# Overview of the sparkins_jenkins Repo

This repo is a Chef app that creates a jenkins server to test the sparkins project.

# Requirements
The following must be installed to use this repo:

- [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [ChefDK](https://downloads.chef.io/chef-dk/)

----

# To Test
This repo uses two types of testing; they are [Serverspec](http://serverspec.org) tests for the provisioned vm created by test-kitchen and [ChefSpec](https://github.com/sethvargo/chefspec) tests for testing the sparkins_jenkins cookbook contained in `cookbooks/sparkins_jenkins`.

## Running the ChefSpec tests
1. Change to the cookbook directory: ```cd cookbooks/sparkins_jenkins```
2. Run rspec: ```rspec```

## Running the ServerSpec tests
1. Converge the jenkins node using test-kitchen: ```kitchen converge```
2. Run the tests on the converged node: ```kitchen verify```
3. Destroy the node: ```kitchen destroy```

**Note:** Running ```kitchen test``` will run all three steps in one command if the tests pass. If the tests fail, the vm will **NOT** be destroyed. While developing this Chef app, you can repeat steps 1 and 2 to make changes and test them.

----

# To Deploy
While using the kitchen vm is perfectly fine for this case, there's also a chef-provisioning recipe that can be used to deploy the app to a "production" server. In this case it's just another Virtualbox vm but it could easily be changed to an AWS instance.

## Deploy to a production node
Run the following: ```chef provision production --sync -n sj-production-01 -o port=8888```

This will provision a Virtualbox machine with the Chef Policy defined in the `Policyfile.rb`, the hostname defined by the `-n` flag and forward port 8080 to port 8888. Once provisioning is complete, you can access the instance by browsing to [http://localhost:8888](http://localhost:8888). 

----

# References
- [Policyfiles: A Guided Tour](https://www.chef.io/blog/2015/08/18/policyfiles-a-guided-tour/)
- [Completely Automatic Jenkins](https://www.cloudbees.com/sites/default/files/completelyautomaticjenkins.pdf)