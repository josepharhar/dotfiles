mkpasswd -c | sed -e 'sX/bashX/zshX' | tee -a /etc/passwd
