class spacewalk::repo::server (
  $spacewalk_repo_enabled   = '1',
  $spacewalk_repo_gpgcheck  = '1',
  $spacewalk_repo_release   = '2.8',
  $spacewalk_repo_gpgkey    = 'https://copr-be.cloud.fedoraproject.org/results/@spacewalkproject/spacewalk-2.8/pubkey.gpg',

  $copr_repo_enabled    = '1',
  $copr_repo_gpgcheck   = '1',
  $copr_repo_gpgkey     = 'https://copr-be.cloud.fedoraproject.org/results/@spacewalkproject/java-packages/pubkey.gpg',
){

  case $::osfamily {
    'RedHat': {
      case $::operatingsystem {
        'Fedora': {
          $repo = "https://copr-be.cloud.fedoraproject.org/results/@spacewalkproject/spacewalk-${spacewalk_repo_release}/fedora-${::operatingsystemmajrelease}-\$basearch/"
        }
        'RedHat', 'CentOS': {
          $repo = "https://copr-be.cloud.fedoraproject.org/results/@spacewalkproject/spacewalk-${spacewalk_repo_release}/epel-${::operatingsystemmajrelease}-\$basearch/"
        }
      }
      yumrepo {'spacewalk-project':
        enabled  => $spacewalk_repo_enabled,
        descr    => "Spacewalk ${spacewalk_repo_release} Repository",
        gpgcheck => $spacewalk_repo_gpgcheck,
        gpgkey   => $spacewalk_repo_gpgkey,
        baseurl  => $repo,
    }

      yumrepo {'copr-java':
        enabled       => $copr_repo_enabled,
        descr         => 'Copr repo for java packages owned by @spacewalkproject',
        gpgcheck      => $copr_repo_gpgcheck,
        gpgkey        => $copr_repo_gpgkey,
        baseurl       => "https://copr-be.cloud.fedoraproject.org/results/@spacewalkproject/java-packages/epel-7-x86_64/",
        repo_gpgcheck => '0',
      }
    }
    default: {
      fail("OS ${::operatingsystem} not supported")
    }
  }
}


