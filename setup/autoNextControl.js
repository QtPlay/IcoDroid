function Controller()
{

}

Controller.prototype.IntroductionPageCallback = function()
{
    var widget = gui.currentPageWidget();
    if(installer.isOfflineOnly()) {
        if (!installer.isInstaller()) {
            if (widget !== null) {
                widget.findChild("PackageManagerRadioButton").visible = false;
                widget.findChild("UpdaterRadioButton").visible = false;
                widget.findChild("UninstallerRadioButton").checked = true;
                gui.clickButton(buttons.NextButton);
            }
        }
    } else {
        if (installer.isUpdater()) {
            if (widget !== null) {
                widget.findChild("PackageManagerRadioButton").checked = false;
                widget.findChild("UpdaterRadioButton").checked = true;
                widget.findChild("UninstallerRadioButton").checked = false;
                gui.clickButton(buttons.NextButton);
            }
        } else if(installer.isPackageManager()) {
            if (widget !== null) {
                widget.findChild("PackageManagerRadioButton").checked = true;
                widget.findChild("UpdaterRadioButton").checked = false;
                widget.findChild("UninstallerRadioButton").checked = false;
                gui.clickButton(buttons.NextButton);
            }
        }
    }
}
