function Controller()
{

}

Controller.prototype.IntroductionPageCallback = function()
{
    if (installer.isUpdater()) {
        // Get the current wizard page
        var widget = gui.currentPageWidget();
        if (widget !== null) {
            // Don't show buttons because we just want to uninstall the software
            widget.findChild("PackageManagerRadioButton").checked = false;
            widget.findChild("UpdaterRadioButton").checked = true;
            widget.findChild("UninstallerRadioButton").checked = false;
            gui.clickButton(buttons.NextButton);
        }
    } else if(installer.isPackageManager()) {
        // Get the current wizard page
        var widget = gui.currentPageWidget();
        if (widget !== null) {
            // Don't show buttons because we just want to uninstall the software
            widget.findChild("PackageManagerRadioButton").checked = true;
            widget.findChild("UpdaterRadioButton").checked = false;
            widget.findChild("UninstallerRadioButton").checked = false;
            gui.clickButton(buttons.NextButton);
        }
    }
}
