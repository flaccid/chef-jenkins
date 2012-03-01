maintainer       "Fletcher Nichol"
maintainer_email "fnichol@nichol.ca"
license          "Apache 2.0"
description      "Installs and configures Jenkins CI server & slaves"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.5"
%w(runit java iptables).each { |cb| depends cb }

recipe "jenkins::default", "Installs a Jenkins CI server using the jenkins-ci.org/redhat RPM. The recipe also generates an ssh private key and stores the ssh public key in the node ‘jenkins[:pubkey]’ attribute for use by the node recipes."

attribute "jenkins/mirror",
  :display_name => "jenkins Mirror",
  :description => "Base URL for downloading Jenkins (server).",
  :default => "http://updates.jenkins-ci.org",
  :required => "optional",
  :recipes => [ "jenkins::default" ]
  
attribute "jenkins/java_home",
  :display_name => "jenkins Java Home",
  :description => "Java install path, used for for cli commands.",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/server/user",
  :display_name => "jenkins Server User",
  :description => "User the Jenkins server runs as.",
  :default => "jenkins",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/server/group",
  :display_name => "jenkins Server Group",
  :description => "Jenkins user primary group.",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/server/port",
  :display_name => "jenkins Server Port",
  :description => "TCP listen port for the Jenkins server.",
  :default => '8080',
  :recipes => [ "jenkins::default" ]

attribute "jenkins/server/url",
  :display_name => "jenkins Server URL",
  :description => "Base URL of the Jenkins server.",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/server/plugins",
  :display_name => "jenkins Server Plugins",
  :description => "Download the latest version of plugins in this list, bypassing update center.",
  :recipes => [ "jenkins::default" ]