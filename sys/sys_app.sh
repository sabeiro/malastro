####--------------------------------node-------------------------------
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install npm@latest -g
sudo npm install -g npm-check-updates
sudo apt-get install gcc g++ make
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
###--------------------------------react-----------------------------
sudo npm install -g create-react-app
sudo npm install -g react-native-cli
sudo apt install -y adb
sudo echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="12d1", ATTR{idProduct}=="107e", MODE="0660", GROUP="plugdev", SYMLINK+="android%n"' > /etc/udev/rules.d/51-android.rules
###--------------------------------java---------------------------------
sudo apt update
sudo apt install -y openjdk-11-jdk
sudo apt install -y openjdk-8-jdk
sudo apt install -y default-jdk 
locate openjdk | grep JAVA_HOME
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
export JRE_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre"
sudo update-alternatives --config java
##--------------------------------cordova-------------------------
sudo npm install -g cordova
cordova create hello com.example.hello HelloWorld
cordova platform add android
cordova requirements
##--------------------------------ionic---------------------------
sudo npm install -g ionic 
###-------------------------------gradle--------------------------------------
wget https://downloads.gradle-dn.com/distributions/gradle-6.4.1-bin.zip
unzip gradle-6.4.1-bin.zip
sudo mv gradle-6.4.1 /usr/local/gradle
sudo chown sabeiro:sabeiro /usr/local/gradle
sudo vim /etc/profile.d/gradle.sh
export PATH=/usr/local/gradle/bin:$PATH
source /etc/profile.d/gradle.sh
###-------------------------------android-debug----------------------------
sudo apt-get install android-tools-adb android-tools-fastboot
adb version
sudo adb start-server
adb devices
###-------------------------------android-sdk------------------------------
export ANDROID_HOME="/usr/lib/android-sdk/"
export ANDROID_HOME="$HOME/share/android-sdk"
export ANDROID_SDK_ROOT="$HOME/share/android-sdk"
export PATH="${PATH}:${ANDROID_HOME}tools/bin/:${ANDROID_HOME}platform-tools/"
alias sdkmanager="sdkmanager --sdk_root=${ANDROID_HOME}"
cordova requirements
cd $ANDROID_HOME
wget https://dl.google.com/android/repository/commandlinetools-linux-6514223_latest.zip
unzip commandlinetools-linux-6514223_latest.zip
sudo find $1 -type f -exec chmod 644 {} \;
sudo find $1 -type d -exec chmod 755 {} \;
sudo chown $USER:$USER -R $ANDROID_HOME
yes | sdkmanager --licenses


react-native init barcode
cd barcode
npm install react-native-svg --save
ncu -u
npm install

