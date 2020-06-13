execute 'apt-get update'

%w{ git build-essential libssl-dev libreadline-dev}.each do |pkg|
  package pkg
end

git "/home/ubuntu/.rbenv" do
  user "ubuntu"
  repository "git://github.com/sstephenson/rbenv.git"
end

git "/home/ubuntu/.rbenv/plugins/ruby-build" do
  user "ubuntu"
  repository "git://github.com/sstephenson/ruby-build.git"
end

git "/home/ubuntu/.rbenv/plugins/ruby-update" do
  user "ubuntu"
  repository "git://github.com/rkh/rbenv-update.git"
end

file '/home/ubuntu/.bashrc' do
  action :create
end

file '/home/ubuntu/.bashrc' do
  action :edit
  block do |content|
    next if content.match %r{export PATH="$HOME/.rbenv/bin:$PATH}
    appendix = <<~EOS
      # rbenv
      export PATH="$HOME/.rbenv/bin:$PATH
      eval "$(rbenv init -)"
    EOS
    content << appendix
  end
end

execute 'rbenv install 2.3.1'do
  user "ubuntu"
end
