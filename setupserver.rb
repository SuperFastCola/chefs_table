Chef::Log.info("******Setting Server******")

Chef::Log.info("******Adding PHP INI Setting and Restarting Server.******")

file "/etc/php.d/custom.ini" do
  owner 'root'
  group 'root'
  mode '0644'
  content <<-EOH
    short_open_tag = On
    display_errors = On
    date.timezone = UTC
  EOH
  action :create
end

Chef::Log.info("******Restart Apache******")

service 'httpd' do
  action :restart
end

Chef::Log.info("******Running Script.******")

script "change_repo" do
  interpreter "bash"
  user "deploy"
  cwd "/srv/www/current"
  code <<-EOH
    /usr/bin/git checkout master
    /usr/bin/git pull
    /usr/bin/git add --all
    /usr/bin/git commit -m "Initial Commit"
  EOH
end

Chef::Log.info("******Adding Deloy to Apache Group.******")

script "add_deploy_to_apache" do
  interpreter "bash"
  user "root"
  code <<-EOH
    usermod -a -G apache deploy
  EOH
end