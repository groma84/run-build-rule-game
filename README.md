Insert
export ERL_AFLAGS="-kernel shell_history enabled"
into your .bash_rc (or similar) to enable session-spanning iex command history

Windows with WSL2:
To access the Phoenix server get the WSL2 ip via `wsl hostname -I` and use that instead of localhost in the browser
