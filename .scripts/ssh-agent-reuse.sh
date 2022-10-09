#!/usr/bin/env bash

set_agent_file=/tmp/set-ssh-agent.env
agent_pid_file=/tmp/ssh-agent_.pid

agent_data=''

if [ ! -f $set_agent_file ] || [ ! -f $agent_pid_file ]; then
	agent_data=`ssh-agent -s`
	echo "$agent_data" | head -n 2 > $set_agent_file
fi

eval `cat $set_agent_file`

if [ -f $agent_pid_file ]; then
	agent_pid=`cat $agent_pid_file`

	if ! kill -0 $agent_pid  &> /dev/null; then
		agent_data=`ssh-agent -s`

		eval $agent_data
		echo "$agent_data" | head -n 2 > $set_agent_file
		echo $SSH_AGENT_PID > $agent_pid_file
	fi
else
	eval $agent_data
	echo $SSH_AGENT_PID > $agent_pid_file
fi

echo "export SSH_AGENT_PID=$SSH_AGENT_PID; export SSH_AUTH_SOCK=$SSH_AUTH_SOCK;"
