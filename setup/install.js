function Component()
{
    installer.setValue("BinaryName", installer.value("RunProgram"));

    var orgFolder = installer.value("TargetDir");
    if (installer.value("os") === "win") {
        var programFiles = installer.environmentVariable("ProgramW6432");
        if(programFiles.length === 0) {
            QMessageBox.critical("os.not64", qsTr("Error"), qsTr("This Program is an 64bit Program. You can't install it on a 32bit machine"));
            gui.rejectWithoutPrompt();
        } else {
            var localProgFiles = installer.environmentVariable("ProgramFiles");
            installer.setValue("TargetDir", orgFolder.replace(localProgFiles, programFiles));
            if(installer.isInstaller())
                installer.addWizardPage(component, "ShortcutPage", QInstaller.ReadyForInstallation);
        }
    }

    if(installer.isInstaller())
        installer.addWizardPage(component, "UserPage", QInstaller.TargetDirectory);
}

Component.prototype.createOperations = function()
{
    if (installer.value("os") === "win") {
        installer.setValue("RunProgram", "@TargetDir@/@BinaryName@");
    } else if(installer.value("os") === "mac") {
        installer.setValue("RunProgram", "@TargetDir@/Contents/MacOS/@BinaryName@");
    } else if(installer.value("os") === "x11") {
        installer.setValue("RunProgram", "@TargetDir@/@BinaryName@");
    }

    try {
        component.createOperations();

        if (installer.value("os") === "win") {
            component.addOperation("CreateShortcut", "@RunProgram@.exe", "@StartMenuDir@/@BinaryName@.lnk");
            if(installer.isOfflineOnly())
                component.addOperation("CreateShortcut", "@TargetDir@/@MaintenanceToolName@.exe", "@StartMenuDir@/@MaintenanceToolName@.lnk");
            else {
                component.addOperation("CreateShortcut", "@TargetDir@/@MaintenanceToolName@.exe", "@StartMenuDir@/@MaintenanceToolName@.lnk");
                component.addOperation("CreateShortcut", "@TargetDir@/@MaintenanceToolName@.exe", "@StartMenuDir@/ManagePackages.lnk", "--manage-packages");
                component.addOperation("CreateShortcut", "@TargetDir@/@MaintenanceToolName@.exe", "@StartMenuDir@/Update.lnk", "--updater");
                component.addOperation("CreateShortcut", "@TargetDir@/@MaintenanceToolName@.exe", "@StartMenuDir@/Uninstall.lnk", "uninstallOnly=1");
            }

            if(installer.isInstaller()) {
                var pageWidget = gui.pageWidgetByObjectName("DynamicShortcutPage");
                if (pageWidget !== null && pageWidget.shortcutCheckBox.checked)
                    component.addOperation("CreateShortcut", "@RunProgram@.exe", "@DesktopDir@/@BinaryName@.lnk");
            }

            component.addElevatedOperation("Execute", "@TargetDir@/vcredist_x64.exe", "/quiet", "/norestart");
            component.addElevatedOperation("Delete", "@TargetDir@/vcredist_x64.exe");
        } else if (installer.value("os") === "x11") {
            component.addOperation("CreateDesktopEntry",
                                   "@BinaryName@.desktop",
                                   "Version=1.0\nType=Application\nTerminal=false\nExec=@RunProgram@\nName=@BinaryName@\nIcon=@TargetDir@/main.png");
        }
    } catch (e) {
        print(e);
    }
}
