function Component()
{
	if (installer.value("os") === "win") {//TODO check
		var programFiles = installer.value("TargetDir");
		if(programFiles.indexOf(" x(x86)") > -1) {
			var index = programFiles.replace(" x(x86)", "");
			installer.setValue("TargetDir", programFiles);
		}
	} else if(installer.value("os") === "mac") {
		var appFolder = installer.value("TargetDir");
		appFolder += ".app";
		installer.setValue("TargetDir", appFolder);
	}

	installer.addWizardPage(component, "shortcutPage", QInstaller.ReadyForInstallation);
}

Component.prototype.createOperations = function()
{
	try {
		component.createOperations();

		var pageWidget = gui.pageWidgetByObjectName("DynamicshortcutPage");
		if (pageWidget != null) {
			if(pageWidget.shortcutCheckBox.checked) {
				if (installer.value("os") === "win")//TODO test
					component.addOperation("CreateShortcut", "@TargetDir@/@ProductName@.exe", "@DesktopDir@/@ProductName@.lnk");
				else if (installer.value("os") === "mac")
					component.addOperation("CreateShortcut", "@TargetDir@/@ProductName@.app", "@DesktopDir@/@ProductName@");
			}
		}

		if (installer.value("os") === "win")
			component.addElevatedOperation("Execute", "@TargetDir@/vcredist_x64.exe", "/quiet", "/norestart");

	} catch (e) {
		print(e);
	}
}
