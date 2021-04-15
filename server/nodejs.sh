# install
sudo npm i -g react-native-scripts create-react-app create-react-native-app react-native
sudo npm i -g babel-cli babel-preset-es2015 babel-preset-react babel --save-dev
#watches limit
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

