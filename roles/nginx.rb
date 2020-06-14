package "nginx"

template "/etc/nginx/nginx.conf" do
  source "../files/nginx.conf"
  owner "root"
  group "root"
  mode '644'
  notifies :run, 'execute[restart nginx]'
end

execute "restart nginx"  do
  command '/etc/init.d/nginx restart'
end
