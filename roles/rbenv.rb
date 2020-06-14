=begin
HOME_DIR = "/home/ubuntu"
RBENV_DIR = "#{HOME_DIR}/.rbenv"
RBENV_PATH = "#{RBENV_DIR}/bin"

execute 'apt-get update'

%w{git build-essential libssl-dev libreadline-dev}.each do |pkg|
  package pkg
end

git RBENV_DIR do
  user "ubuntu"
  repository "git://github.com/sstephenson/rbenv.git"
end

git "#{RBENV_DIR}/plugins/ruby-build" do
  user "ubuntu"
  repository "git://github.com/sstephenson/ruby-build.git"
end

git "#{RBENV_DIR}/plugins/ruby-update" do
  user "ubuntu"
  repository "git://github.com/rkh/rbenv-update.git"
end

execute "#{RBENV_PATH}/rbenv install 2.3.1" do
  not_if "test -d #{RBENV_DIR}/versions/2.3.1"
  user "ubuntu"
end
=end
