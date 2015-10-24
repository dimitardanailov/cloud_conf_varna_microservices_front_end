sudo apt-get update
echo "Installing nginx..."
sudo apt-get install -y nginx
echo "Making necessary links..."
sudo rm -Rf /usr/share/nginx/html
sudo ln -s /vagrant/client /usr/share/nginx/html
echo "Copying configuration..."
sudo cp /vagrant/nginx/default /etc/nginx/sites-available/default
sudo service nginx restart
echo "Done!"