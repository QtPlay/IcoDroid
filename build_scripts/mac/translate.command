#!/bin/sh
# Add this as a build step with the arguments:
#workingDir: %{sourceDir}

lupdate -no-obsolete -locations relative ./IcoDroid.pro
lrelease -compress -nounfinished ./IcoDroid.pro
