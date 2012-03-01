maintainer       "Fletcher Nichol"
maintainer_email "fnichol@nichol.ca"
license          "Apache 2.0"
description      "Installs and configures Jenkins CI server & slaves"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.5"
%w(runit java iptables).each { |cb| depends cb }

recipe "jenkins::default", "Installs a Jenkins CI server using the jenkins-ci.org/redhat RPM. The recipe also generates an ssh private key and stores the ssh public key in the node ‘jenkins[:pubkey]’ attribute for use by the node recipes."