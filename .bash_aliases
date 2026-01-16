# User specific aliases and functions

# Useful aliases
alias c='clear'

#Safety first!
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Change directories
alias cdt='cd ~/rc/psp/test'
alias cdw='cd ~/Work/Trapeze/rc/psp/test'

# iftop ignore broadcast packets
alias iftop="sudo /usr/sbin/iftop -f 'not ether host ff:ff:ff:ff:ff:ff'"

alias perli='do{print("perl> ");$_x=<>;chomp $_x;print(eval($_x)."\n")}while($_x ne "q")'

# Memory usage (real pressure excluding disk cache)
alias memreal='free -m | awk '\''NR==2{printf "Real usage: %.1fG / %.1fG (%.0f%%)\n", ($3-$6)/1024, $2/1024, (($3-$6)/$2)*100}'\'
