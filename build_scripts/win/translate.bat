: Add this as a build step with the arguments:
:workingDir: %{sourceDir}
@echo off

lupdate -locations relative ./IcoDroid.pro
lrelease -compress -nounfinished ./IcoDroid.pro
