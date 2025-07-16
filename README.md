# Ansible Server files

This is just a collection of ansible playbooks and a website that displays info. Good luck trying to figureout if there is anything good there. I also have some documentation here for me so it may not make a lot of sense.
*TBH there are lots of hidden files lol, password files, inv files ect*

## Current tasks (This is also things that I'm just doing)
- [X] Migrate the ansible server to a cleaner server
- [X] Migrate the file server to a cleaner server
- [X] Build a better notification server
- [X] Fix the IP address's of all the servers
- [X] Finish the playbook to check the status of the gtnh server
    - I added a service for the server to run automatically, but there is also now a playbook to check
- [X] Add a page to the website to add a task to run
- [X] Change the gather playbook to output to json
- [X] Create a playbook to check if a device's disk usage is above 90% usage, and let me know
- [ ] Setting up Logging for the server
- [ ] Recreate the host files to have the vars included in the hosts files

## Updates

I am removing the website at the moment so it's going to stay where it is at the moment, and not being updated, but I'm making a new one to tie in everything from all of my servers.

I moved the website to github.com/sanktem/glass

### Installed packages on this server
```
apt install git vim curl python3-pip apache2 nodejs cifs-utils psmisc npm
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

### Passwords and Secrets

I have added the passwords to a hidden folder called passwords where I'm using a ansible-vault to serve the passwords to the playbooks. Adding something like the following to the playbooks

```
#Add this to the yml files you are needing it for
vars_files:
  - /path/to/secrets.yml

tasks:
  - name: Use secret token
    uri:
      url: "http://example.com/api?token={{ gotify_token_ansible }}"
      method: POST
      body_format: json
      body:
        message: "Hello"
```


## THIS IS ALL GONE BUT I WANT TO LEAVE THE README INFO

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
