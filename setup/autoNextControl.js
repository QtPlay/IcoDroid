function Controller()
{

}

Controller.prototype.IntroductionPageCallback = function()
{
    installer.setValue("AllUsers", "true");

    var widget = gui.currentPageWidget();
    if (widget !== null) {
        if(installer.isOfflineOnly()) {
            if (!installer.isInstaller()) {
                widget.findChild("PackageManagerRadioButton").visible = false;
                widget.findChild("UpdaterRadioButton").visible = false;
                widget.findChild("UninstallerRadioButton").checked = true;
                gui.clickButton(buttons.NextButton);
            }
        } else {
            if (installer.isUpdater()) {
                widget.findChild("PackageManagerRadioButton").checked = false;
                widget.findChild("UpdaterRadioButton").checked = true;
                widget.findChild("UninstallerRadioButton").checked = false;
                gui.clickButton(buttons.NextButton);
            } else if(installer.isPackageManager()) {
                widget.findChild("PackageManagerRadioButton").checked = true;
                widget.findChild("UpdaterRadioButton").checked = false;
                widget.findChild("UninstallerRadioButton").checked = false;
                gui.clickButton(buttons.NextButton);
            } else if(installer.value("uninstallOnly") === "1") {
                widget.findChild("PackageManagerRadioButton").checked = false;
                widget.findChild("UpdaterRadioButton").checked = false;
                widget.findChild("UninstallerRadioButton").checked = true;
                gui.clickButton(buttons.NextButton);
            }
        }
    }
}

Controller.prototype.FinishedPageCallback = function()
{
    if (installer.isInstaller() && installer.value("os") === "win") {
        var isAllUsers = (installer.value("AllUsers") === "true");
        if(!isAllUsers || installer.gainAdminRights()){
            var args  = [
                            installer.value("ProductUUID"),
                            "@TargetDir@\\@MaintenanceToolName@.exe",
                            isAllUsers ? "HKEY_LOCAL_MACHINE" : "HKEY_CURRENT_USER",
                            installer.environmentVariable("ProgramW6432").length > 0 ? "WOW6432Node\\Microsoft" : "Microsoft"
                        ];
            installer.execute("@TargetDir@/regSetUninst.bat", args);
            if(isAllUsers)
                installer.dropAdminRights();
        }
    }
}
