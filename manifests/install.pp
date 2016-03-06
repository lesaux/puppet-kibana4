# == Class: kibana4
#
# Installation
#
class kibana4::install {

  case $kibana4::install_method {

    'archive': {
      contain kibana4::install::archive
    }

    'package': {
      contain kibana4::install::package
    }

    default: {
      fail("Valid installation methods are `package` or `archive`")
    }

  }

}
