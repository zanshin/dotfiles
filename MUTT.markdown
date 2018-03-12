# Introduction

The `mutt` directory holds my mutt configuration. It is minimally working. Mail is synced between the Maildirs on my local computer and the IMAP servers at my ISP and Gmail via mbsync. Mail is sent via msmtp. Neomutt is installed, which includes the sidebar.

I'm using GnuPG to encrypt the passwords for my email accounts, and eventually hope to have that
plumbed into mutt so that digitally signed and encrypted emails are possible.

At a minimum this setup requires these packages be installed:

* mutt
* (Neo)vim
* mbsync
* msmtp
* GnuPG


