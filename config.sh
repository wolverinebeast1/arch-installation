#Clone my dotfiles repo
git clone https://github.com/wolverinebeast1/dotfiles

#Changes directory to the dotfiles
cd dotfiles || exit 

#Copy the configurations to the home folder
cp -r .config ~/
cp .zshrc ~/
cp .local/share/fonts ~/
cp .bashrc ~/
cp .xprofile ~/
cp ohmyposh_themes ~/

