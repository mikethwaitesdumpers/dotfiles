# Detect Cygwin (Windows)
case "`uname`" in
  CYGWIN*) CYGWIN=true  ;;
  *)       CYGWIN=false ;;
esac

# Detect whether there's a terminal (rather than a command like scp),
# and check we're not running a forced command like in gitolite
if [ "$TERM" != "dumb" -a -z "$BASH_EXECUTION_STRING" ]; then
    HAS_TERMINAL=true
else
    HAS_TERMINAL=false
fi

# Standard config files, nicely split up
for file in ~/.bash/*; do
    source "$file"
done

# Custom settings for this machine/account
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi

# *After* doing the rest, show the current directory contents, except in
# Cygwin (Git Bash) home directory - there's a load of system files in there
if $HAS_TERMINAL && ! ($CYGWIN && [ "$PWD" = "$HOME" ]); then
    l
fi

# Git Cygwin loads this file *and* .bash_profile so set a flag to tell
# .bash_profile not to load .bashrc again
BASHRC_DONE=true
