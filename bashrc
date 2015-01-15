# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
   . /etc/bashrc
fi

# User specific aliases and functions
code_format()
{
    /usr/bin/astyle                \
        --style=ansi               \
        --indent=spaces=4          \
        --min-conditional-indent=0 \
        --indent-classes           \
        --suffix=none              \
        --indent-col1-comments     \
        --unpad-paren              \
        --keep-one-line-statements \
        --align-pointer=type       \
        --keep-one-line-blocks     \
        $@
}
alias astyle=code_format

rclean()
{
    find $1 -type f | egrep "(\.[ao]$|~$)" | xargs rm
}

make_etags()
{
  rm -f TAGS;
  find . | grep "\.[ch][p]*$" \
       | grep -v bak | grep -v build | grep -v vs2008 | xargs etags -a
}

make_s3_etags()
{
  find . -type f | grep -v Head | grep -v .svn | grep -v ".bak/" | grep -v Bin | egrep "html$|js$|\.h$" | xargs ctags -e
}

export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R --tabs=4'

#PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '

#PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$ '

PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '
export VISUAL="emacs -nw"
export TERM='xterm-256color'

alias clean='\rm -f *~ \#*\#'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
#alias ls='ls -sF --color'
alias ls='ls -sFG'
alias logcat='adb logcat -c ; adb logcat'

alias changeidhook='scp -p -P 29418 sjbuild:hooks/commit-msg .git/hooks/'

export LS_COLORS='di=94:ex=32:fi=0:ln=36:pi=5:so=5:bd=5:cd=5:or=31:*.deb=90'
#export LSCOLORS='di=94:ex=32:fi=0:ln=36:pi=5:so=5:bd=5:cd=5:or=31:*.deb=90'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# my bin
export PATH=$PATH:"~/bin"
export PATH=/opt/local/bin:$PATH

# Java

# not very elegant, probably want to load a system specific
# config file instead of an os specific clause
if [[ "$OSTYPE" == "linux-gnu" ]]; then
        echo 'linux'
elif [[ "$OSTYPE" == "darwin"* ]]; then
        export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
elif [[ "$OSTYPE" == "cygwin" ]]; then
        export JAVA_HOME="c:/Program Files/Java/jdk1.8.0_11"
        alias open='cygstart'
else
        echo 'Unknown'
fi

export PATH=$PATH:$JAVA_HOME/bin
export ANT_CC=gcc

# ANDROID_ROOT is defined here
#source ~/git/security/immersion.rc
#source ~/git/security/android.rc

# utils should get their own file really
up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

hex2dec(){
  echo "ibase=16; $@"|bc
}
dec2hex(){
  echo "obase=16; $@"|bc
}

# golang stuff
export GOPATH=$HOME/git/go
export PATH=$PATH:"$GOPATH/bin"

