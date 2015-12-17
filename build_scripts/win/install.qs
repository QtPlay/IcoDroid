function Component()
{
	 var programFiles = installer.environmentVariable("ProgramFiles");
	 var end = programFiles.substr(programFiles.length - 6, 6);
	 if(end == " (x86)")
		installer.setValue("TargetDir", programFiles.substring(0, programFiles.length - 6) + "/IcoDroid");

	installer.addWizardPage(component, "shortcutPage", QInstaller.ReadyForInstallation);
}

Component.prototype.createOperations = function()
{
	try {
		component.createOperations();

		var pageWidget = gui.pageWidgetByObjectName("DynamicshortcutPage");
		if (pageWidget != null) {
			if(pageWidget.shortcutCheckBox.checked) {
				if (installer.value("os") === "win")
					component.addOperation("CreateShortcut", "@TargetDir@/IcoDroid.exe", "@DesktopDir@/IcoDroid.lnk");
			}
		}

		if (installer.value("os") === "win")
			component.addElevatedOperation("Execute", "@TargetDir@/vcredist_x64.exe", "/quiet", "/norestart");

	} catch (e) {
		print(e);
	}
}
