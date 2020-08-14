
#!/bin/bash

# when script exits, then will kill all processes started by it
# but read at the bottom. we will wait for crtl c to exit
trap "kill 0" EXIT

# stdout & erros are not benn redirected 
# want to see them in terminal

docker-compose up &
export django_docker_server_pid=$!
echo
echo "django docker server pid == $django_docker_server_pid"
echo

echo "pwd == $(pwd)"
echo "changing directory only for this script not the terminal"
echo "because script is running in a sub shell"
cd -- frontend
echo "pwd == $(pwd)"

./node_modules/gulp/bin/gulp.js watch &
export gulp_watch_pid=$!
echo
echo "gulp watch pid == $gulp_watch_pid"
echo

while sleep 300; do echo "gulp watch pid == $gulp_watch_pid"; done &
while sleep 300; do echo "django docker server pid == $django_docker_server_pid"; done &


# the script will not exit 
# when stopped with ctrl c, then will kill both processes
wait 
