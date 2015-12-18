function Component()
{
    installer.setValue("BinaryName", installer.value("RunProgram"));

    var orgFolder = installer.value("TargetDir");
    if (installer.value("os") === "win") {
        var programFiles = installer.environmentVariable("ProgramW6432");
        if(programFiles.length === 0) {
            QMessageBox.critical("os.not64", "Error", "This Program is an 64bit Program. You can't install it on a 32bit machine");
            gui.rejectWithoutPrompt();
        } else {
            var localProgFiles = installer.environmentVariable("ProgramFiles");
            installer.setValue("TargetDir", orgFolder.replace(localProgFiles, programFiles));
            installer.setValue("RunProgram", "@TargetDir@/@BinaryName@");
        }
    } else if(installer.value("os") === "mac") {
        installer.setValue("TargetDir", orgFolder + ".app");
        installer.setValue("RunProgram", "@TargetDir@/Contents/MacOS/@BinaryName@");
    }

    if (installer.value("os") !== "mac")
        installer.addWizardPage(component, "shortcutPage", QInstaller.ReadyForInstallation);
}

Component.prototype.createOperations = function()
{
    try {
        component.createOperations();

        if (installer.value("os") !== "mac") {
            var pageWidget = gui.pageWidgetByObjectName("DynamicshortcutPage");
            if (pageWidget !== null) {
                if(pageWidget.shortcutCheckBox.checked) {
                    if (installer.value("os") === "win")
                        component.addOperation("CreateShortcut", "@RunProgram@.exe", "@DesktopDir@/@BinaryName@.lnk");
                }
            }
        }

        if (installer.value("os") === "win") {
            component.addOperation("CreateShortcut", "@RunProgram@.exe", "@StartMenuDir@/@BinaryName@.lnk");
            component.addOperation("CreateShortcut", "@TargetDir@/Uninstall.exe", "@StartMenuDir@/Uninstall.lnk");

            component.addElevatedOperation("Execute", "@TargetDir@/vcredist_x64.exe", "/quiet", "/norestart");
            component.addElevatedOperation("Delete", "@TargetDir@/vcredist_x64.exe");
        }

    } catch (e) {
        print(e);
    }
}
