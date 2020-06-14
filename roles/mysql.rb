=begin
MYSQL_ROOT_PASS = "yjro_tkym"

package "mysql-client"
package "mysql-server"

utf8mb4_settting = <<"EOS"

[mysqld]
character-set-server = utf8mb4
character-set-client-handshake  = FALSE
character_set_server            = utf8mb4
collation_server                = utf8mb4_unicode_ci
innodb_file_format = Barracuda
innodb_file_per_table = 1
innodb_large_prefix

[client]
default-character-set=utf8mb4

EOS

execute "set db charset to utf8mb4" do
  command <<-EOF
    echo '#{utf8mb4_settting}' >> /etc/my.cnf
  EOF
end

service 'mysql' do
  action [:restart]
end

# MySQL初期設定
# rootユーザーじゃなくてもログイン可能にする & Pass設定
execute "mysql_secure_installation" do
  user "root"
  only_if "mysql -u root -e 'show databases' | grep information_schema" # パスワードが空の場合
  command <<-EOL
      mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '#{MYSQL_ROOT_PASS}';"
      mysql -u root -p#{MYSQL_ROOT_PASS} -e "FLUSH PRIVILEGES;"
  EOL
end
=end
