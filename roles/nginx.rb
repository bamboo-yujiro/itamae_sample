package "nginx"

template "/etc/nginx/sites-enabled/rails_app.conf" do
  source "../files/nginx/sites-enabled/rails_app.conf"
  owner "root"
  group "root"
  mode '644'
  notifies :run, 'execute[restart nginx]'
end

execute "restart nginx"  do
  command '/etc/init.d/nginx restart'
end
