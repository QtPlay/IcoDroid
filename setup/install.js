function Component()
{
    var orgFolder = installer.value("TargetDir");
    if (installer.value("os") === "win") {
        var programFiles = installer.environmentVariable("ProgramW6432");
        if(programFiles.length === 0) {
            QMessageBox.critical("os.not64", "Error", "This Program is an 64bit Program. You can't install it on a 32bit machine");
            gui.rejectWithoutPrompt();
        } else {
            var localProgFiles = installer.environmentVariable("ProgramFiles");
            installer.setValue("TargetDir", orgFolder.replace(localProgFiles, programFiles));
        }
    } else if(installer.value("os") === "mac") {
        installer.setValue("TargetDir", orgFolder + ".app");
        var runPath = installer.value("RunProgram");
        var runName = runPath.substr(runPath.lastIndexOf("/") + 1);
        installer.setValue("RunProgram", runPath + ".app/Contents/MacOs/" + runName);
    }

    installer.addWizardPage(component, "shortcutPage", QInstaller.ReadyForInstallation);
}

Component.prototype.createOperations = function()
{
    try {
        component.createOperations();

        var runPath = installer.value("RunProgram");
        var runName = runPath.substr(runPath.lastIndexOf("/") + 1);

        var pageWidget = gui.pageWidgetByObjectName("DynamicshortcutPage");
        if (pageWidget !== null) {
            if(pageWidget.shortcutCheckBox.checked) {
                if (installer.value("os") === "win")
                    component.addOperation("CreateShortcut", runPath + ".exe", "@DesktopDir@/" + runName + ".lnk");
                else if (installer.value("os") === "mac")//TODO test
                    component.addOperation("CreateShortcut", "@TargetDir@", "@DesktopDir@/" + runName + ".app");
            }
        }

        if (installer.value("os") === "win") {
            component.addOperation("CreateShortcut", runPath + ".exe", "@StartMenuDir@/" + runName + ".lnk");
            component.addOperation("CreateShortcut", "@TargetDir@/Uninstall.exe", "@StartMenuDir@/Uninstall.lnk");

            component.addElevatedOperation("Execute", "@TargetDir@/vcredist_x64.exe", "/quiet", "/norestart");
            component.addElevatedOperation("Delete", "@TargetDir@/vcredist_x64.exe");
        }

    } catch (e) {
        print(e);
    }
}
