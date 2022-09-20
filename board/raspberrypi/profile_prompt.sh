if [ "$PS1" ]; then
	if [ "`id -u`" -eq 0 ]; then
		export PS1='$(whoami)@$(hostname):$(pwd)# '
	else
		export PS1='$(whoami)@$(hostname):$(pwd)$ '
	fi
fi