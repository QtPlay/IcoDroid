#!/bin/sh
# Add this as a build step with the arguments:
#workingDir: %{sourceDir}

lupdate -locations relative ./Icodroid.pro
lrelease -compress -nounfinished ./Icodroid.pro
