#!/bin/sh
# Add this as a build step with the arguments:
#workingDir: %{sourceDir}

lupdate -locations relative ./IcoDroid.pro
lrelease -compress -nounfinished ./IcoDroid.pro
