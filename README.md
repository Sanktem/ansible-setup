# Ansible Server files

This is just a collection of ansible playbooks and a website that displays info. Good luck trying to figureout if there is anything good there. I also have some documentation here for me so it may not make a lot of sense.
*TBH there are lots of hidden files lol, password files, inv files ect*

## Current tasks (This is also things that I'm just doing)
- [  ] Build a playbook to install a samaba server
- [  ] Migrate the ansible server to a cleaner server
- [  ] Migrate the file server to a cleaner server
- [  ] Create a better shell config and create a playbook to deploy it
- [  ] Build a better notification server

### Installed packages on this server
```
apt install git vim curl python3-pip apache2 nodejs cifs-utils psmisc
```

### Hidden File called inventory.ini, set as the following

```
[speical]
x.x.x.x #host name

[vm]
x.x.x.x #host name

[container]
x.x.x.x #host name
```

### How to run a playbook (and other interesting things):

```
ansible-playbook -i inventory.ini <playbook name>
```

To run the telegram message system that is encrypted is:
* I'm going to setup a different way to notify me about issues

```
ansible-playbook --extra-vars 'message="whatever the message is"' playbooks/telegram_test.yml --vault-password-file pass.txt

or 

sh send_telegram $1 (This has two files telegram_token.txt, and chat_id.txt that you will need to put the token IDs)
```

To setup the nodejs server for the inv site, all the node files that are needed are hidden, because I dont want to upload them
* There is a "script" that should move all the files for an apache2 sever
* I have a bit more that I want to add to the site like a logging file, and setting up sechudualed tasks

```
cd inventory-site
npm init -y
npm install express
npm install cors
node server.js
```
