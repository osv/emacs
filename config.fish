function nvm                                                                                                                                                   
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv                                                                                                       
end                                                                                                                                                            

# git status
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "⇡"
set -g __fish_git_prompt_char_upstream_behind "⇣"
set -g __fish_git_prompt_char_upstream_prefix " "

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green

function fish_prompt --description 'Write out the prompt'
	if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    echo -n -s (set_color blue) (date "+%H:%M") " $__fish_prompt_cwd" (prompt_pwd) (__fish_vcs_prompt) "$__fish_prompt_normal" '> '
end

function fish_right_prompt
    set -l status_copy $status
    set -l status_code $status_copy

    set -l color_normal (set_color normal)
    set -l color_error (set_color $fish_color_error)
    set -l color "$color_normal"

    switch "$status_copy"
        case 0 "$__sol_status_last"
            set status_code
    end

    set -g __sol_status_last $status_copy

    if test "$status_copy" -ne 0
        set color "$color_error"
    end

    if set -l job_id (last_job_id)
        echo -sn "$color(%$job_id)$color_normal "
    end

    if test ! -z "$status_code"
        echo -sn "$color($status_code)$color_normal "
    end

    if test "$CMD_DURATION" -gt 250
        set -l duration (echo $CMD_DURATION | humanize_duration)
        echo -sn "$color($duration)$color_normal "
    end
end

function man --description "wrap the 'man' manual page opener to use color in formatting"
  # # start of bold:
  # set -x LESS_TERMCAP_md (printf "\e[1;31m")
  # # end of all formatting:
  # set -x LESS_TERMCAP_me (printf "\e[0m")

  # # start of standout (inverted):
  # set -x LESS_TERMCAP_so (printf "\e[1;40;92m")
  # # end of standout (inverted):
  # set -x LESS_TERMCAP_se (printf "\e[0m")
  # # (no change – I like the default)

  # start of underline:
  set -x LESS_TERMCAP_us (printf "\e[1;32m")
  # end of underline:
  set -x LESS_TERMCAP_ue (printf "\e[0m")
  # (no change – I like the default)

  env man $argv
end

alias e='exa -ghl --git'
alias eee='exa -ghl --git'

alias l='ls -lah'

alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
