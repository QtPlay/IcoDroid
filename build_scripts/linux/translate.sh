#!/bin/sh
# Add this as a build step with the arguments:
#workingDir: %{sourceDir}

#application
lupdate -locations relative ./Icodroid.pro
lrelease -compress -nounfinished ./Icodroid.pro

#setup
lupdate -locations relative setup/autoNextControl.js setup/install.js setup/ShortcutPage.ui setup/UserPage.ui -ts setup/de.ts
lrelease -compress -nounfinished setup/de.ts
