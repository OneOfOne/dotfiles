alias ports="sudo ss -nl -tup"
alias pss="ps -Ao pid:5,state:1,user,cmd | grep -v grep | egrep"

function dig-any {
	command dig $@ ANY | egrep -v '^$|^;'
}