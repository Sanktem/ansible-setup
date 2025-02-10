# ansible-setup

TBH there are lots of hidden files lol, password files, inv files ect

Hidden File called inventory.ini, set as the following

```
[DEB]
x.x.x.x #host name

[REHL]
x.x.x.x #host name

[container]
x.x.x.x #host name
```

How to run a playbook:

```
ansible-playbook -i inventory.ini <playbook name>
```

To run the telegram message system that is encrypted is:

```
ansible-playbook --extra-vars 'message="whatever the message is"' playbooks/telegram_test.yml --vault-password-file pass.txt

or 

sh send_telegram $1 (This has two files telegram_token.txt, and chat_id.txt that you will need to put the token IDs)
```

To setup the nodejs server for the inv site, all the node files that are needed are hidden, because I dont want to upload them

```
cd inventory-site
npm init -y
npm install express
npm install cors
node server.js
```
