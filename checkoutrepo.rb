Chef::Log.info("******Running Script.******")

script "change_repo" do
  interpreter "bash"
  user "deploy"
  cwd "/srv/www/current"
  code <<-EOH
   	/usr/bin/git config --global user.name "Anthony Baker"
    /usr/bin/git config --global user.email anthony.baker@deluxeluxury.com
    /usr/bin/git checkout master
    /usr/bin/git pull
    /usr/bin/git add --all
    /usr/bin/git commit -m "Initial Commit"
  EOH
end