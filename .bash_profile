# Source the corporate profile, too, duh.
if [ -f ~/.corporate-profile ]; then
  source ~/.corporate-profile
fi

alias cat="lolcat"

# homebrew-installed version of emacs
# need to remember to update alias when you update...
# on non-macos systems, change / update this
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo "Running Linux, don't need to alias emacs"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # osx need to set to proper emacs location
  alias emacs="/usr/local/Cellar/emacs/25.2/bin/emacs"
fi

export M2_HOME=/Applications/apache-maven-3.5.0
export PATH=$PATH:$M2_HOME/bin
export MAVEN_OPTS=-Xmx1024m

export ANT_HOME="/usr/local/ant"
export PATH="${ANT_HOME}/bin:${PATH}"

#export SCALA_HOME="/Library/Scala"
export SCALA_HOME="/usr/local/opt/scala/idea"
export PATH="${SCALA_HOME}/bin:${PATH}"

export PATH=$PATH:/usr/local/spark/bin

export GOPATH=$HOME/workspace
#export GOROOT=/usr/local/opt/go/libexc
#export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:$GOPATH/bin

export JAVA_OPTS="-Djava.awt.headless=true -Dfile.encoding=UTF-8 -server -Xms4096m -Xmx4096m -XX:NewSize=512m -XX:MaxNewSize=512m -XX:PermSize=512m -XX:MaxPermSize=512m -XX:+CMSClassUnloadingEnabled"
#export JAVA_HOME=/Library/Java/Home
function setjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH=$JAVA_HOME/bin:$PATH
  fi
 }
 function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
 }
setjdk 1.8

# bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

export PATH=~/Documents/scripts:$PATH
export PATH="/usr/local/bin:$PATH"
alias days="python ~/Documents/scripts/days.py"

# Git configuration
# Branch name in prompt
source ~/.git-prompt.sh
PS1='[\W$(__git_ps1 " (%s)")]\$ '
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
# Tab completion for branch names
source ~/.git-completion.bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
