exe=gate
logLevel=2
exePid=$exe.pid
logfile=console.log

mkdir -p log

cwd=$(pwd)
export CLIENT_PUBLIC_KEY=$cwd/key/client_public_key.pem
export CLIENT_PRIVATE_KEY=$cwd/key/client_private_key.pem

export SERVER_PUBLIC_KEY=$cwd/key/server_public.pem
export SERVER_PRIVATE_KEY=$cwd/key/server_private.key

export GAME_WEB_CERT_FILE=$cwd/key/gameweb.abc.pem
export GAME_WEB_KEY_FILE=$cwd/key/gameweb.abc.key

export ROBOT_KEY=abcdefg123456

function check_pid() {
	if [ -f $exePid ];then
		pid=`cat $exePid`
		if [ -n $pid ];then
			running=`ps -p $pid|grep -v "PID TTY" | wc -l`
			return $running
		fi
	fi
	return 0
}

function start() {
	check_pid
	running=$?
	if [ $running -gt 0 ];then
		echo -n "$exe now is running already, pid="
		cat $exePid
		return 1
	fi

	nohup ./$exe -v=$logLevel -logtostderr=true -log_dir=./log &> $logfile &
	echo $! > $exePid
	echo "$exe started..., pid=$!"
}

function stop() {
	pid=`cat $exePid`
	kill $pid
	echo "$exe stopped..."
}

function restart() {
	stop
	sleep 1
	start
}

function status() {
	check_pid
	running=$?
	if [ $running -gt 0 ];then
		echo -n "$exe now is running, pid="
		cat $exePid
	else
		echo "$exe is stopped"
	fi
}

function tailf() {
	tail -f $logfile
}

function help() {
	echo "$0 start|stop|restart|status|tail"
}

if [ "$1" == "" ];then
	help
elif [ "$1" == "stop" ];then
	stop
elif [ "$1" == "start" ];then
	start
elif [ "$1" == "restart" ];then
	restart
elif [ "$1" == "status" ];then
	status
elif [ "$1" == "tail" ];then
	tailf
fi

