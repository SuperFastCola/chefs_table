script "change_locatime_to_eastern" do
  interpreter "bash"
  user "root"
  cwd "/etc"
  code <<-EOH
    rm localtime
    ln -s /usr/share/zoneinfo/US/Eastern localtime
  EOH
end