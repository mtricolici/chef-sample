
# Latest version supported by errbit
default['errbit']['ruby']['version']='2.7.2'

# requirements needed to install a specific ruby version with rvm
# TODO: use metapackage build-essentials + what's missing
default['errbit']['ruby']['dependencies'] = %w[gawk autoconf automake bison libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool libyaml-dev pkg-config sqlite3 zlib1g-dev libgmp-dev libreadline-dev libssl-dev g++ make]

default['errbit']['rvm']['keyserver'] = 'keyserver.ubuntu.com'
default['errbit']['rvm']['keys'] = '409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB'

