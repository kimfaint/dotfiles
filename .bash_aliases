# User specific aliases and functions

# Useful aliases
alias c='clear'

#Safety first!
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Change directories
alias cdt='cd /opt/rapid/src/test'

# iftop ignore broadcast packets
alias iftop="sudo /usr/sbin/iftop -f 'not ether host ff:ff:ff:ff:ff:ff'"
