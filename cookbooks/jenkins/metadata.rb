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
  
attribute "jenkins/server/user",
  :display_name => "jenkins Server User",
  :description => "User the Jenkins server runs as.",
  :default => "jenkins",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/server/group",
  :display_name => "jenkins Server Group",
  :description => "Jenkins user primary group.",
  :default => "nobody",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/server/port",
  :display_name => "jenkins Server Port",
  :description => "TCP listen port for the Jenkins server.",
  :default => '8080',
  :recipes => [ "jenkins::default" ]

attribute "jenkins/server/plugins",
  :display_name => "jenkins Server Plugins",
  :description => "Download the latest version of plugins in this list, bypassing update center.",
  :recipes => [ "jenkins::default" ]
  
attribute "jenkins/server/plugins",
  :display_name => "jenkins Server Plugins",
  :description => "Download the latest version of plugins in this list, bypassing update center.",
  :recipes => [ "jenkins::default" ]
  
attribute "jenkins/node/ssh_host",
  :display_name => "jenkins Node SSH Host",
  :description => "Hostname or IP Jenkins should connect to when launching an SSH slave.",
  :required => "optional",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/node/ssh_port",
  :display_name => "jenkins Node SSH Port",
  :description => "SSH slave port.",
  :required => "optional",
  :default => '22',
  :recipes => [ "jenkins::default" ]
  
attribute "jenkins/node/ssh_user",
  :display_name => "jenkins Node SSH User",
  :description => "SSH slave user name (only required if jenkins server and slave user is different).",
  :required => "optional",
  :default => "jenkins",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/node/ssh_pass",
  :display_name => "jenkins Node SSH Password",
  :description => "SSH slave password (not required when server is installed via default recipe).",
  :required => "optional",
  :default => nil,
  :recipes => [ "jenkins::default" ]

attribute "jenkins/node/ssh_private_key",
  :display_name => "jenkins Node SSH Private Key",
  :description => "Sjenkins master defaults to: `~/.ssh/id_rsa` (created by the default recipe).",
  :required => "optional",
  :default => nil,
  :recipes => [ "jenkins::default" ]

attribute "jenkins/http_proxy/variant",
  :display_name => "jenkins HTTP Proxy Variant",
  :description => "use `nginx` or `apache2` to proxy traffic to jenkins backend (`nil` by default).",
  :required => "optional",
  :default => nil,
  :recipes => [ "jenkins::default" ]
  
attribute "jenkins/http_proxy/www_redirect",
  :description => "add a redirect rule for ‘www.*’ URL requests (“disable” by default).",
  :required => "optional",
  :default => "disable",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/http_proxy/listen_ports",
  :description => "list of HTTP ports for the HTTP proxy to listen on ([80] by default).",
  :required => "optional",
  :default => [ "80" ],
  :recipes => [ "jenkins::default" ]

attribute "jenkins/http_proxy/host_name",
  :description => "primary vhost name for the HTTP proxy to respond to (`node[:fqdn]` by default).",
  :required => "optional",
  :default => nil,
  :recipes => [ "jenkins::default" ]

attribute "jenkins/http_proxy/host_aliases",
  :description => "optional list of other host aliases to respond to (empty by default).",
  :required => "optional",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/http_proxy/client_max_body_size",
  :description => "max client upload size (“1024m” by default, nginx only).",
  :required => "optional",
  :default => "1024m",
  :recipes => [ "jenkins::default" ]
