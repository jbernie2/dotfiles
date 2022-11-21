export FZF_CTRL_T_COMMAND="find ."

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden'
else
  export FZF_DEFAULT_COMMAND="find ."
fi

# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/opt/homebrew/opt/fzf/shell/key-bindings.bash"
