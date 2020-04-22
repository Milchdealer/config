# Install ohmyzsh (do this manually)
#curl -Lo /tmp/ohmyzsh_install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
#chmod 500 /tmp/ohmyzsh_install.sh
#/tmp/ohmyzsh_install.sh

# Change theme to "agnoster"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc
# Add aliases
cp ../resources/sh_aliases ~/.sh_aliases
echo "source ~/.sh_aliases" >> ~/.zshrc
# Add additional environment variables
cp ../resources/sh_env ~/.sh_env
echo "source ~/.sh_env" >> ~/.zshrc
