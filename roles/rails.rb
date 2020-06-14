MYSQL_ROOT_PASS = "yjro_tkym"
DB_NAME = "rails_sample_app"
HOME_DIR = "/home/ubuntu"
RBENV_DIR = "#{HOME_DIR}/.rbenv"
RBENV_PATH = "#{RBENV_DIR}/bin"

package "libmysqlclient-dev"

git "#{HOME_DIR}/rails_itamae_sample" do
  user "ubuntu"
  repository "git://github.com/bamboo-yujiro/rails_itamae_sample.git"
end

execute "cd #{HOME_DIR}/rails_itamae_sample; #{RBENV_PATH}/rbenv exec bundle i" do
  user "ubuntu"
end

execute "mysql -u root -p#{MYSQL_ROOT_PASS} -e \"CREATE DATABASE #{DB_NAME};\"" do
  user "root"
  not_if "mysql -u root -p#{MYSQL_ROOT_PASS} -e 'show databases' | grep #{DB_NAME}"
end

execute "cd #{HOME_DIR}/rails_itamae_sample; #{RBENV_PATH}/rbenv exec bundle exec unicorn_rails -c config/unicorn.rb -E development -D" do
  not_if "test -f /tmp/unicorn.pid"
  user "ubuntu"
end
