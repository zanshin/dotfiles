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

Future additions:

* imapfilter
* notmuch
* runlock
* elinks
* urlview
* lbdbq
* lbdb-fetchaddr


## Disclaimer
THIS REPOSITORY IS NOT SUPPORTED. USE AT YOUR OWN RISK.
It is still a work-in-progress. Once it's complete, I'll have a write up on how to create a similar
set up for yourself. Until then, using this will destroy all life as we know it, and cause the heat
death of the universe to occur sooner than expected.
