# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#export ZSH_THEME="robbyrussell"
export ZSH_THEME="zanshin"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git textmate osx ruby rvm pow)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# added my path 2011.7.19
export PATH=/usr/local/bin:/usr/local/apache-maven-2.2.1/bin:/usr/local/maven-1.1/bin:/Developer/android/android-sdk-mac_x86/tools:/usr/local/mysql/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/Users/mark/.rvm/bin

# added RVM stuff
# load RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# -------------------------------------------------------------------
# set up history
#   keep 100 commands internally (histsize)
#   store history in .zsh_history
#   write out 100 commands to stored history (savehist)
# -------------------------------------------------------------------
histsize=100
histfile=~/.zsh_history
savehist=100

# copied from .bash_aliases 2001.07.19
# -------------------------------------------------------------------
# some alias settings, just for fun
# -------------------------------------------------------------------
#alias 'today=calendar -A 0 -f ~/calendar/calendar.mark | sort'
alias 'today=calendar -A 0 -f /usr/share/calendar/calendar.mark | sort'
alias 'dus=du -sckx * | sort -nr'
alias 'adventure=emacs -batch -l dunnet'
alias 'mailsize=du -hs ~/Library/mail'
alias 'bk=cd $OLDPWD'
alias 'ttop=top -ocpu -R -F -s 2 -n30'
alias lh='ls -a | egrep "^\."'
alias lsd='ls -aFhlG'

# -------------------------------------------------------------------
# make some commands (potentially) less destructive
# -------------------------------------------------------------------
alias 'rm=rm -i'

# -------------------------------------------------------------------
# Jboss
# -------------------------------------------------------------------
alias 'startjboss=/usr/local/jboss-4.0.5.GA/bin/run.sh &'
alias 'stopjboss=/usr/local/jboss-4.0.5.GA/bin/shutdown.sh --shutdown'

# -------------------------------------------------------------------
# Mercurial (hg)
# -------------------------------------------------------------------
alias 'h=hg status'
alias 'hc=hg commit'
alias 'push=hg push'
alias 'pull=hg pull'
alias 'clone=hg clone'

# -------------------------------------------------------------------
# Git
# -------------------------------------------------------------------
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gta='git tag -a -m'
alias gf='git reflog'

# leverage an alias from the ~/.gitconfig
alias gh='git hist'
alias gt='git today'

# -------------------------------------------------------------------
# Oddball stuff
# -------------------------------------------------------------------
alias 'sloc=/usr/local/sloccount/bin/sloccount'

# fakecall.net 
alias fakecall='curl --request POST --user "7852368181:ghoti" http://api.fakecall.net/v1/account/7852368181/call'

# necessary to make rake work inside of zsh
alias rake="noglob rake"

# sort files in current directory by the number of words they contain
alias 'wordy=wc -w * | sort | tail -n10'
alias 'filecount=find . -type f | wc -l'

# -------------------------------------------------------------------
# some Octopress helpers
# -------------------------------------------------------------------
alias 'generate=date ; rake generate ; date;'
alias 'deploy=rake deploy > deploy.log ; tail -n 3 deploy.log ;'
alias 'np=newpost.rb'

# copy .htaccess files for zanshin.net and its image sub-directory
alias 'zhtaccess=scp /Users/mark/Projects/octopress/zanshin/source/htaccess/.htaccess markhnic@markhnichols.com:~/public_html/zanshin.net ; scp /Users/mark/Projects/octopress/zanshin/source/images/.htaccess markhnic@markhnichols.com:~/public_html/zanshin.net/images ;'

# copy .htaccess files for cello.zanshin.net and its images and videos sub-directories
alias 'chtaccess=scp /Users/mark/Projects/octopress/solfege/source/htaccess/.htaccess markhnic@markhnichols.com:~/public_html/cello ; scp /Users/mark/Projects/octopress/solfege/source/images/.htaccess markhnic@markhnichols.com:~/public_html/cello/images ; scp /Users/mark/Projects/octopress/solfege/source/videos/.htaccess markhnic@markhnichols.com:~/public_html/cello/videos ;'

# deploy zanshin.net and move its .htaccess files
alias 'dz=deploy ; zhtaccess ;'

# deploy cello.zanshin.net and move its .htaccess files
alias 'ds=deploy ; chtaccess ;'

# -------------------------------------------------------------------
# Functions
# -------------------------------------------------------------------
# any function from http://onethingwell.org/post/14669173541/any
any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any " >&2 ; return 1
    else
        ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
    fi
}
# -------------------------------------------------------------------
# Functions ported directly from .bashrc
# -------------------------------------------------------------------
# turn hidden files on/off in Finder
function hiddenOn() { defaults write com.apple.Finder AppleShowAllFiles YES ; }
function hiddenOff() { defaults write com.apple.Finder AppleShowAllFiles NO ; }

# remote machine functions
function palantir() { ssh mhn@palantir.ome.ksu.edu ; }
function pvnc() { open vnc://palantir.ome.ksu.edu ; }
function ksunix() { ssh mhn@unix.ksu.edu ; }
function veld() { ssh mhn@veld.ome.ksu.edu ; }
function dev() { ssh mhn@ome-dev-as1.ome.campus ; }


# function for Bluehost
function bh() { ssh markhnic@markhnichols.com ; }

# postgres functions
function psqlstart() { /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l logfile start ; }
function psqlstop() { /usr/local/pgsql/bin/pg_ctl stop ; }

# view man pages in Preview
function pman() { ps=`mktemp -t manpageXXXX`.ps ; man -t $@ > "$ps" ; open "$ps" ; }

# devvm functions
function startvm() { VBoxHeadless --startvm devvm ; }
function stopvm() { VBoxManage controlvm devvm poweroff ; }
function devvm() { ssh -p 10022 ome@localhost ; }
function devmount() { mount_smbfs //ome:ch1cag0@localhost:10139/ome /Users/$USERNAME/Projects/devvm/ ; }

# apache tomcat functions
function tomcatup() { /usr/local/tomcat/bin/startup.sh ; }
function tomcatdown() { /usr/local/tomcat/bin/shutdown.sh ; }

# function to show interface IP assignments
function ips() {
  foo=`/Users/mark/bin/getip.py; /Users/mark/bin/getip.py en0; /Users/mark/bin/getip.py en1`; echo $foo;
} 

# nice mount (http://catonmat.net/blog/another-ten-one-liners-from-commandlingfu-explained)
# displays mounted drive information in a nicely formatted manner
function nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ; }

# mount android source disk image
function mountAndroid() { hdiutil attach /Volumes/Palantir\ HD/androidHD.dmg -mountpoint /Volumes/androidHD ; }

# myIP address
function myip() {
    ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
	ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

#
## new functions
#
s() { pwd > ~/.save_dir ; }
i() { cd "$(cat ~/.save_dir)" ; }

# console function
function console () {
  if [[ $# > 0 ]]; then
    query=$(echo "$*"|tr -s ' ' '|')
    tail -f /var/log/system.log|grep -i --color=auto -E "$query"
  else
    tail -f /var/log/system.log
  fi
}

# finis
# mhn 2011.7.19
