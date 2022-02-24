cd ~

echo "Get npiperelay"
wget https://github.com/jstarks/npiperelay/releases/latest/download/npiperelay_windows_amd64.zip
unzip -o npiperelay_windows_amd64.zip -d npiperelay
rm npiperelay_windows_amd64.zip

echo "Install socat"
sudo apt -y install socat

echo "Add to .bashrc"
cat << 'EOF' >> ~/.bashrc
export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock

ss -a | grep -q $SSH_AUTH_SOCK
if [ $? -ne 0 ]; then
    rm -f $SSH_AUTH_SOCK
    (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$HOME/npiperelay/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
fi
EOF

echo "Reload ~/.bashrc"
exec bash

echo "Done"