export FZF_CTRL_T_COMMAND="find ."

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden'
else
  export FZF_DEFAULT_COMMAND="find ."
fi
