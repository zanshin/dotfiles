Here be Dragons

#Introduction
The `mutt` directory in my dotfiles contains the configuration of my mutt mail setup. This is heavily influenced by [The Homely Mutt](http://stevelosh.com/blog/2012/10/the-homely-mutt/ "The Homely Mutt"). You should go read that from top to bottom several times before attempting to use or mimic my mutt setup.

Unlike Git or Vim or tmux where lack of understanding is relatively harmless, screwing up mutt or offlineimap could result in permanently lost email.

PROCEED AT YOUR OWN RISK.

#Dependencies
This configuration relies upon a number of tools. They are presented in the order The Homely Mutt introduces them. (You did read that, right?)

* [Offlineimap](http://offlineimap.org)
 
    git clone git://github.com/spaetz/offlineimap.git  
    cd offlineimap  
    git checkout 679c491c56c981961e18aa43b31955900491d7a3  
    python setup.py install  

Note: `sudo` may be required for the install step.

* [Mutt](http://www.mutt.org)
 
    $ brew install mutt --sidebar-patch

At present the brew formula for mutt does not include the sidebar patch. Follow [these steps](http://stackoverflow.com/questions/20883936/how-to-apply-this-mutt-sidebar-patch) to edit the formula:

    $ brew edit mutt

Scroll down to a section of commands that all start with "option", sort of like:

    option "with-debug", "Build with debug option enabled"
    option "with-trash-patch", "Apply trash folder patch"
    option "with-s-lang", "Build against slang instead of ncurses"
    option "with-ignore-thread-patch", "Apply ignore-thread patch"
    option "with-pgp-verbose-mime-patch", "Apply PGP verbose mime patch"
    option "with-confirm-attachment-patch", "Apply confirm attachment patch"

Add this line to the bottom of the options:

    option "with-sidebar-patch", "Apply sidebar patch"

Scroll down further to the section with all the patches, e.g.

    patch do
      url "http://patch-tracker.debian.org/patch/series/dl/mutt/1.5.21-6.2+deb7u1/features/trash-folder"
      sha1 "6c8ce66021d89a063e67975a3730215c20cf2859"
    end if build.with? "trash-patch"

And add this block:

    patch do
      url "https://raw.github.com/nedos/mutt-sidebar-patch/7ba0d8db829fe54c4940a7471ac2ebc2283ecb15/mutt-sidebar.patch"
      sha1 "1e151d4ff3ce83d635cf794acf0c781e1b748ff1"
    end if build.with? "sidebar-patch"

Exit the editor and run the `brew install mutt --with-sidebbar-patch` command.

* [urlview](https://github.com/sigpipe/urlview)
 
    $ brew install urlview

* [msmtp](http://msmtp.sourceforge.net)
 
    $ brew install msmtp

* [contacts](http://gnufoo.org/contacts/) (requires full Xcode install)
 
    $ brew install contacts

* [notmuch](http://notmuchmail.org)
 
    $ brew install notmuch

#Setup
With the dependencies installled, symlinks can be created to the contents of the `~/.dotfiles/mutt` directory.

    $ ln -s ~/.dotfiles/mutt ~/.mutt
    $ ln -s ~/.dotfiles/mutt/offlineimaprc ~/.offlineimaprc
    $ ln -s ~/.dotfile/mutt/msmtprc ~/.msmtprc
    $ ln -s ~/.dotfiles/mutt/notmuch-config ~/.notmuch-config
    $ ln -s ~/.dotfiles/mutt/urlview ~/.urlview

To download mail:

    $ mkdir ~/.mail
    $ offlineimap

Note, this will likely take a very long time.

#Add new mail account

##Update `offlineimaprc`

* Add account name to `accounts`
* Create `[Account ...]` section for new account
* Create `[Repository ...-Local]` section for new account
* Create `[Repository ...-Remote]` section for new account

##Add Keychain entries
Use `Keychain Access` app to create new `http://imap.server.tld` and `smtp://smtp.server.tld` password entries for the new account.

##Synchronize email
Run offlineimap to download email.

    $ offlineimap

The first time the new keychain entries are accesed you will have to repsond to a GUI dialog. Click `Always allow`. Resolve any errors before proceeding, this way the download can happen while the rest of the steps below are completed.

##Update Mutt configuration
Edit `~/.muttrc`. Update `Account Settings` section. Add new account's mailboxes to list that appears in sidebar. Reorder sidebar if desired.

Add `folder-hook` for new account.

##Create `accounts` entry
The `folder-hook` in `.muttrc` requires a new file in the `~/.mutt/accounts` directory. Copy an existing entry, rename it, and edit the contents for the new account.

##Create msmtprc entry
In order to send mail create a new `account` entry in ~/.msmtprc.

##Test new account
Once offlineimap has completed the initial mail download, you should see the account in mutt.

