local return_code="%(?..%{$fg_bold[red]%})"

function ssh_connection() {
	if [[ -n $SSH_CONNECTION ]]; then
		echo "%{$fg_bold[red]%}(ssh):"
	fi
}

function cur_dir() {
	local pwd=$PWD
	regexp-replace pwd $GOPATH/src/github.com '✪'
	regexp-replace pwd $GOPATH/src '☯'
	regexp-replace pwd $HOME '~'

	echo "${pwd}"
}

local pre_arch="$fg_bold[white]❨%{$reset_color%}"
local post_arch="$fg_bold[white]❩%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}${pre_arch}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}${post_arch}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[yellow]%} ⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[magenta]%}↑"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[red]%}●"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[white]%}●"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[red]%}✕"

export ZSH_THEME_TERM_TITLE_IDLE='$(cur_dir)'

if [[ $UID -eq 0 ]]; then
	local user_host='$fg_bold[red]%}%n%{$fg_bold[white]%}@%{$fg_bold[yellow]%}%m%{$reset_color%}'
else
	local user_host='$fg_bold[yellow]%}%n%{$fg_bold[white]%}@%{$fg_bold[yellow]%}%m%{$reset_color%}'
fi

local cur_dir='${pre_arch}$fg_bold[cyan]%}$(cur_dir)%{$reset_color%}${post_arch}'
local git_status='$(git_prompt_info)'

PROMPT="%{$return_code%}┏━%{$reset_color%} $(ssh_connection)${user_host} ${cur_dir} ${git_status} %{$return_code%}%(?..%?)
┗━━%{$reset_color%}%B➤%b "
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
