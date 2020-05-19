
##First things first

1. When any intern joins the team then sir will provide phoenixgen systems email credentials on your personal email id. interns has to change the password immedietly and the email is ready to use.
2. using the phoenixgen systems email, intern needs to create account on slack, trello, bitbucket and firebase firebase.
3. create a project folder, go to that folder and enter the following command 

 $ git clone <https://username@bitbucket.org/Phoenixgen/soilsesoul.git>
 $ git fetch && git checkout <branch_name>
 
4. After this, commit and push the changes to bitbucket by typing following commands

 $ git add .
 $ git commit -m "initial commit"
 $ git push origin <branch_name>
 
##flutter download/installation and setup

5. Download and install flutter sdk from this site https://flutter.dev/docs/get-started/install. Follow guidelines for installation as per the os preference.
6. After installing flutter sdk, next step is to add path to make flutter command work.
to make it work go to home directory and press ctrl+h to show hidden files.
open .bashrc file or .zshrc file and paste the following path in that file and save it. Make sure to paste the perfect path where your flutter sdk is located.

$ export PATH="$PATH:[PERFECT_PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin"

after saving the file, open terminal and run the following command to make the changes permanent.

$ source ~/. bashrc

NOTE: if you have zsh terminal then replace bash with zsh.

use this link for reference: https://youtu.be/nWBvhJb1PmA

7. Run $ flutter command in terminal and now the flutter starts to work fine.
8. Run $ flutter doctor to see issues.

##Android studio download/installation and setup

9. Download android studion from this link https://developer.android.com/studio.
10. Next step is to open terminal and go to /Downloads/android-studio-ide-192.6392135-linux/android-studio/bin
11. After this run the following command and android studio will start working.

    $ ./studio.sh
    
12. For reference use this link: https://www.youtube.com/watch?v=axtVId9ASmY
13. After installation is done, next step is to head over to the extension section and install dart and flutter extension.

NOTE: JDK must be installed

##VS Code download/installation and setup

14. Download VS code from here : https://code.visualstudio.com/download
15. Install VS code and go to extension section and install flutter and dart extention.

##setting up android toolchain and sdk

13. Again go to home and open your .bashrc or .zshrc file and scroll to the end of file and paste the following path and save it.

  export ANDROID_HOME=$HOME/Android/Sdk
  export PATH=$PATH:$ANDROID_HOME/tools
  export PATH=$PATH:$ANDROID_HOME/platform-tools

14. run $ flutter doctor and it should output that android studio, flutter, vs code and android toolchain working fine.

##Setup emulator device and compiling app

15. Next connect your phone via USB cable to PC and make sure to keep developer option and USB debugging to ON state.
16. run $ flutter doctor and make sure you have no issues.
17. Next step is to keep google-services.json file in soilsesoul/android/app directory.

##SHA-1 key generation

18. Generate SHA-1 key and add it to firebase console by following command on terminal

	$ keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
	
NOTE: if it ask for password type "android"

19. After this go to soilsesoul/lib and open main.dart and click run option and you will be able to compile and run the app.




