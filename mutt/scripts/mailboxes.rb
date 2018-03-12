#!/usr/bin/env ruby

PRIORITY = {
  'mark' => '00',
  'mark.Sent' => '01',
  'mark.Drafts' => '02',
  'mark.Archive' => '03',
  'mark.Trash' => '04',
  'mark.Spam' => '05',
  'root' => '00',
  'root.Sent' => '02',
  'root.Drafts' => '03',
  'root.Archive' => '04',
  'root.Trash' => '05',
  'root.Spam' => '06',
  'marknichols' => '00',
  'marknichols.Sent' => '02',
  'marknichols.Drafts' => '03',
  'marknichols.Archive' => '04',
  'marknichols.Trash' => '05',
  'marknichols.Spam' => '06',
  'codeprole' => '00',
  'codeprole.Sent' => '02',
  'codeprole.Drafts' => '03',
  'codeprole.Archive' => '04',
  'codeprole.Trash' => '05',
  'codeprole.Spam' => '06',
}

mailboxes = []
Dir.chdir(ENV['HOME'] + '/.mail') do
  Dir['{mark,root,marknichols,codeprole}/*'].each do |d|
    mailboxes << %{"+#{d}"}
  end
end
mailboxes.sort! do |a, b|
  account_a, mailbox_a = a.split('.')
  account_b, mailbox_b = b.split('.')
  key_a = account_a + PRIORITY.fetch(mailbox_a || account_a, '99') + mailbox_a.to_s
  key_b = account_b + PRIORITY.fetch(mailbox_b || account_b, '99') + mailbox_b.to_s
  key_a <=> key_b
end

File.open(ENV['HOME'] + '/.mutt/mailboxes.mutt', 'w') do |f|
# File.open('/tmp/mailboxes.mutt', 'w') do |f|
  f.puts "mailboxes #{mailboxes.join(' ')}"
end
