maintainer       "Fletcher Nichol"
maintainer_email "fnichol@nichol.ca"
license          "Apache 2.0"
description      "Installs and configures Jenkins CI server & slaves."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.5"

%w(runit java iptables).each { |dep| depends dep }

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
  
attribute "jenkins/server/home",
  :display_name => "jenkins Server Home",
  :description => "JENKINS_HOME directory.",
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
  :default => "8080",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/server/url",
  :display_name => "jenkins Server URL",
  :description => " Base URL of the Jenkins server.",
  :recipes => [ "jenkins::default" ]  
  
attribute "jenkins/server/plugins",
  :display_name => "jenkins Server Plugins",
  :description => "Download the latest version of plugins in this list, bypassing update center.",
  :type => "array",
  :default => [ "javadoc", "ssh-slaves", "git" ],
  :recipes => [ "jenkins::default" ]
  
attribute "jenkins/node/name",
  :display_name => "jenkins Node Name",
  :required => "optional",
  :description => "Name of the node within Jenkins.",
  :recipes => [ "jenkins::default" ]
  
attribute "jenkins/node/description",
  :display_name => "jenkins Node Description",
  :required => "optional",
  :description => "Jenkins node description.",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/node/executors",
  :display_name => "jenkins Node Executors",
  :default => "1",
  :description => "Number of node executors.",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/node/home",
  :display_name => "jenkins Node Home",
  :default => "/home/jenkins",
  :description => "Home directory (“Remote FS root”) of the node.",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/node/labels",
  :display_name => "jenkins Node Labels",
  :description => "Node labels.",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/node/mode",
  :display_name => "jenkins Node Mode",
  :description => "Node usage mode, “normal” or “exclusive” (tied jobs only).",
  :default => 'normal',
  :recipes => [ "jenkins::default" ]
  
attribute "jenkins/node/launcher",
  :display_name => "jenkins Launch Method",
  :description => "Node launch method, “jnlp”, “ssh” or “command”.",
  :default => 'ssh',
  :recipes => [ "jenkins::default" ]

attribute "jenkins/node/availability",
  :display_name => "jenkins Node Availability",
  :description => "“always” keeps node on-line, “demand” off-lines when idle.",
  :default => 'always',
  :recipes => [ "jenkins::default" ]

attribute "jenkins/node/in_demand_delay",
  :display_name => "jenkins In-Demand Delay",
  :description => "number of minutes for which jobs must be waiting in the queue before attempting to launch this slave.",
  :default => '0',
  :recipes => [ "jenkins::default" ]

attribute "jenkins/node/idle_delay",
  :display_name => "jenkins Node Idle Delay",
  :description => "number of minutes that this slave must remain idle before taking it off-line.",
  :default => '1',
  :recipes => [ "jenkins::default" ]

attribute "jenkins/node/env",
  :display_name => "jenkins Node Environment",
  :description => "“Node Properties” -> “Environment Variables”.",
  :default => nil,
  :recipes => [ "jenkins::default" ]

attribute "jenkins/node/user",
  :display_name => "jenkins Node Environment",
  :description => "user the slave runs as.",
  :default => 'jenkins-node',
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

attribute "jenkins/node/jvm_options",
  :display_name => "jenkins Node Slave JVM Options",
  :description => "SSH slave JVM options.",
  :required => "optional",
  :default => nil,
  :recipes => [ "jenkins::default" ]
  
attribute "jenkins/iptables_allow",
  :display_name => "jenkins iptables Allow",
  :description => "if iptables is enabled, add a rule passing ‘jenkins[:server][:port]’",
  :required => "optional",
  :default => "enable",
  :recipes => [ "jenkins::default" ]
  
attribute "jenkins/http_proxy/variant",
  :display_name => "jenkins HTTP Proxy Variant",
  :description => "use `nginx` or `apache2` to proxy traffic to jenkins backend (`nil` by default).",
  :required => "optional",
  :default => nil,
  :recipes => [ "jenkins::default" ]
  
attribute "jenkins/http_proxy/www_redirect",
  :display_name => "jenkins HTTP WWW Redirect Rule",
  :description => "add a redirect rule for ‘www.*’ URL requests (“disable” by default).",
  :required => "optional",
  :default => "disable",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/http_proxy/listen_ports",
  :display_name => "jenkins HTTP Proxy Listen Ports",
  :description => "list of HTTP ports for the HTTP proxy to listen on ([80] by default).",
  :required => "optional",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/http_proxy/host_name",
  :display_name => "jenkins HTTP Proxy Hostname",
  :description => "primary vhost name for the HTTP proxy to respond to (`node[:fqdn]` by default).",
  :required => "optional",
  :default => nil,
  :recipes => [ "jenkins::default" ]

attribute "jenkins/http_proxy/host_aliases",
  :display_name => "jenkins HTTP Proxy Host Aliases",
  :description => "optional list of other host aliases to respond to (empty by default).",
  :required => "optional",
  :recipes => [ "jenkins::default" ]

attribute "jenkins/http_proxy/client_max_body_size",
  :display_name => "jenkins HTTP Proxy Max Client Upload Size",
  :description => "max client upload size (“1024m” by default, nginx only).",
  :required => "optional",
  :default => "1024m",
  :recipes => [ "jenkins::default" ]
