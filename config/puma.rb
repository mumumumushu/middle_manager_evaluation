# !/usr/bin/env puma

#rails 的运行环境
environment 'production'
threads 2, 16
workers 2

app_name = 'middle_manager_evaluation'

pidfile ".pids/#{app_name}.pid"
state_path ".pids/#{app_name}.state"
stdout_redirect ".pids/puma.stdout.log", ".pids/puma.stderr.log", true

bind "unix://.pids/#{app_name}.sock"
activate_control_app "unix://.pids/pumactl.sock"

# 后台运行
daemonize true
on_restart do
  puts 'On restart...'
end
preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
