### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
fish_add_path --universal $HOME/.local/bin
fish_add_path --universal $HOME/Applications
fish_add_path --universal $HOME/.cargo/bin
fish_add_path --universal /opt/cuda/bin

### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set TERM "xterm-256color"                         # Sets the terminal type
set EDITOR "nvim"                 # $EDITOR use Emacs in terminal
set VISUAL "nvim"              # $VISUAL use Emacs in GUI mode


### "nvim" as manpager
set -x MANPAGER "nvim -c 'set ft=man' -"

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
  fish_vi_key_bindings
  bind --preset -M insert jk 'if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char repaint-mode; end'
end
### END OF VI MODE ###

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# navigation
alias ..='cd ..'
alias ...='cd ../..'

# vim and emacs
alias vim='nvim'
# Changing "ls" to "exa"
alias ls='ls -al --color=always --group-directories-first' # my preferred listing
# reboot and shutdown
alias rb='sudo reboot now'
alias sd='sudo shutdown now'
alias s='speedtest'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# switch between shells
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

# runpod specific alias
set -x NVIDIA_DRIVER_CAPABILITIES compute,graphics,utility
set -x VK_ICD_FILENAMES /etc/vulkan/icd.d/nvidia_icd.json
set -x VK_LAYER_PATH /usr/share/vulkan/implicit_layer.d
set -x CUDA_LAUNCH_BLOCKING 1
set -x seed 3

# Lazy-load pyenv and pyenv-virtualenv
function pyenv
    # Remove this wrapper function
    functions --erase pyenv

    # Initialize pyenv (creates the actual pyenv function)
    /usr/bin/pyenv init - | source

    # Initialize virtualenv if available
    if test -d (pyenv root)/plugins/pyenv-virtualenv
        /usr/bin/pyenv virtualenv-init - | source
    end

    # Call pyenv with the original arguments
    pyenv $argv
end

# Conda config
set -x CONDA_PATH /workspace/miniconda3/bin/conda
function conda
    echo "Lazy loading conda..."
    functions --erase conda
    if test -f $CONDA_PATH
        eval $CONDA_PATH "shell.fish" "hook" | source
        conda $argv
        return
    end
    echo "No conda installation found in $CONDA_PATH"
end


