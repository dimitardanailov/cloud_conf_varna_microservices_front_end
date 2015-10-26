sudo apt-get update

echo "Installing node.js"
# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-with-nvm-node-version-manager-on-a-vps
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
source ~/.profile
apt-get install -y git
nvm install 0.12.7
nvm use v0.12.7
n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local
which node
node -v

echo "Installing ruby with rbenv"
# https://cbednarski.com/articles/installing-ruby/
sudo apt-get install -y libssl-dev zlib1g-dev libreadline-dev

# https://github.com/welaika/jenkins-vagrant/blob/master/provision.sh
sudo -u vagrant git clone git://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
sudo -u vagrant echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.profile
sudo -u vagrant echo 'eval "$(rbenv init -)"' >> /home/vagrant/.profile
sudo -u vagrant git clone git://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build

# no rdoc for installed gems
sudo -u vagrant echo 'gem: --no-ri --no-rdoc' >> /home/vagrant/.gemrc

# install required ruby versions
sudo -u vagrant -i rbenv install 2.1.5
sudo -u vagrant -i rbenv global 2.1.5
sudo -u vagrant -i ruby -v
sudo -u vagrant -i gem install bundler --no-ri --no-rdoc
sudo -u vagrant -i rbenv rehash

echo "Install Compass"
# http://compass-style.org/install/
gem update --system
gem install compass

echo "Setup project"
cd /vagrant/

echo 'Installing npm dependencies'
npm install

echo 'Installing bower'
sudo npm install -g bower

echo 'Installing bower dependencies'
bower install

echo 'Installing grunt'
sudo npm install -g grunt-cli

echo 'Installing imagemin'
sudo npm install --save imagemin
sudo npm install --save imagemin-optipng

echo 'Buld grunt production'
grunt build

echo "Installing nginx..."
sudo apt-get install -y nginx

echo "Making necessary links..."
sudo ln -s /vagrant/nginx.conf /etc/nginx/sites-enabled/vagrant.conf

echo "Copying configuration..."
sudo service nginx restart

echo "Done!"
