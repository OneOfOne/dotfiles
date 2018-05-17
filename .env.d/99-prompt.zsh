local FG_RED="%{$fg_bold[red]%}"
local FG_WHITE="%{$fg_bold[white]%}"
local FG_YELLOW="%{$fg_bold[yellow]%}"
local FG_CYAN="%{$fg_bold[cyan]%}"
local FG_RESET="%{$reset_color%}"
local LEFT_ARCH="$FG_WHITE❰$FG_RESET"
local RIGHT_ARCH="$FG_WHITE❱$FG_RESET"

local LAST_RET="%(?..$LEFT_ARCH$FG_RED%?$RIGHT_ARCH━)"

function ssh_connection() {
	if [[ -n $SSH_CONNECTION ]]; then
		echo "$FG_RED(ssh)$FG_WHITE:"
	fi
}

function cur_dir() {
	local pwd=$PWD
	regexp-replace pwd $GOPATH/src/github.com '✪'
	regexp-replace pwd $GOPATH/src '☯'
	regexp-replace pwd $HOME '~'
	if [ "$pwd" = "~" ]; then
		echo "$pwd"
		return
	fi

	# https://unix.stackexchange.com/a/247008/2759
	echo $pwd | sed 's!\([^/]\)[^/]*/!\1/!g'
}

ZSH_THEME_GIT_PROMPT_PREFIX="$FG_RESET${LEFT_ARCH}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG_RESET${RIGHT_ARCH}"
ZSH_THEME_GIT_PROMPT_DIRTY="$FG_YELLOW ⚡$FG_RESET"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[magenta]%}↑"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="$FG_RED●"
ZSH_THEME_GIT_PROMPT_UNTRACKED="$FG_WHITE●"
ZSH_THEME_GIT_PROMPT_UNMERGED="$FG_RED✕"

export ZSH_THEME_TERM_TITLE_IDLE='$(cur_dir)'

if [[ $UID -eq 0 ]]; then
	local user_host='$FG_RED%n$FG_WHITE@$FG_YELLOW%m$FG_RESET'
else
	local user_host='$FG_YELLOW%n$FG_WHITE@$FG_YELLOW%m$FG_RESET'
fi

local cur_dir='${LEFT_ARCH}$FG_CYAN$(cur_dir)$FG_RESET${RIGHT_ARCH}'
local git_status='$(git_prompt_info)'

PROMPT="$FG_WHITE┏━ $FG_RESET$(ssh_connection)$user_host $cur_dir $git_status
┗━$LAST_RET$FG_WHITE●$FG_RESET "
RPROMPT=""

#dcdccc
#2c2c2c
# def _userPrompt():
# 	out = '\n{ret_code_color}┏━{NO_COLOR}{env_name}'
# 	out = out + ('{BOLD_RED}' if $PROMPT_FIELDS['user'] == 'root' else '{BOLD_YELLOW}') + '{user}'
# 	out = out + '{NO_COLOR}@{BOLD_CYAN}{hostname}{NO_COLOR} '
# 	#out = out + '❨{BOLD_GREEN}{shorter_cwd}{NO_COLOR}❩ {branch_status}'
# 	out = out + '❨{BOLD_GREEN}{shorter_cwd}{NO_COLOR}❩{gitstatus: ❨{}❩ }'
# 	out = out + '{NO_COLOR}{ret_code_color}{ret_code}\n'
# 	out = out + '{ret_code_color}┗━━{NO_COLOR}➤{NO_COLOR} '

# 	$TITLE = '{current_job} ' + _shorter_cwd()
# 	return out
