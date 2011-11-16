# -------------------------------------------------------------------
# .bash_profile
#
# This file is executed for all interactive shells, i.e., ones you
# log into directly. It may be that some console applications
# (Terminal) execute this for all new tabs or instances.
# -------------------------------------------------------------------

# -------------------------------------------------------------------
# Source my bashrc file
# -------------------------------------------------------------------

# get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# -------------------------------------------------------------------
# Build a PATH environment variable
# -------------------------------------------------------------------

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH="~/bin:${PATH}"
fi

# set PATH so it includes /usr/local/sbin if it exists
if [ -d /usr/local/sbin ] ; then
	PATH="/usr/local/sbin:${PATH}"
fi

# set PATH so it includes /usr/local/mysql/bin if it exists
if [ -d /usr/local/mysql/bin ] ; then
    PATH="/usr/local/mysql/bin:${PATH}"
fi

# set PATH so it includes /Developer/android/android-sdk-mac_x86/tools if it exists
if [ -d /Developer/android/android-sdk-mac_x86/tools ] ; then
    PATH="/Developer/android/android-sdk-mac_x86/tools:${PATH}"
fi

# set PATH so it includes /usr/local/jruby/bin if it exists
if [ -d /usr/local/jruby/bin ] ; then
	PATH="/usr/local/jruby/bin:${PATH}"
fi

# set PATH so it includes /usr/local/maven-1.1 for maven 1 stuff
if [ -d /usr/local/maven-1.1/bin ] ; then
	PATH="/usr/local/maven-1.1/bin:${PATH}"
fi

# set PATH so it includes /usr/local/apache-maven-2.2.1/bin if it exists
if [ -d /usr/local/apache-maven-2.2.1/bin ] ; then
	PATH="/usr/local/apache-maven-2.2.1/bin:${PATH}"
fi

# set PATH so it includes /usr/local/sloccount/bin if it exists
if [ -d /usr/local/sloccount/bin ] ; then
	PATH="/usr/local/sloccount/bin:${PATH}"
fi

# prepend /usr/local/bin to the head of the PATH to keep Homebrew happy
if [ -d /usr/local/bin ] ; then
	PATH="/usr/local/bin:${PATH}"
fi

export PATH

# following line added by RVM - mhn 7.15.2011
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function



# finis	
# mhn 2011.7.19