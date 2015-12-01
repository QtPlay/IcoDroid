#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QStandardPaths>
#include <QFileDialog>
#include <QDir>
#include <QMessageBox>

struct ScaleInfo {
	bool isChecked;
	QString subFolderSuffix;
	qreal scaleFactor;
};

MainWindow::MainWindow(QWidget *parent) :
	QMainWindow(parent),
	ui(new Ui::MainWindow),
	settings(new QSettings(this)),
	previewDialog(new IconViewDialog(this)),
	mainIcon()
{
	this->settings->beginGroup(QStringLiteral("paths"));
	if(!this->settings->contains(QStringLiteral("openPath"))) {
		this->settings->setValue(QStringLiteral("openPath"),
								 QStandardPaths::writableLocation(QStandardPaths::PicturesLocation));
	}
	if(!this->settings->contains(QStringLiteral("savePath"))) {
		this->settings->setValue(QStringLiteral("savePath"),
								 QStandardPaths::writableLocation(QStandardPaths::PicturesLocation));
	}
	this->settings->endGroup();

	this->settings->beginGroup(QStringLiteral("templates"));
	if(this->settings->childGroups().isEmpty()) {
		//Create "Launcher Icon"
		this->settings->beginGroup(tr("Launcher Icon"));
		this->settings->setValue(QStringLiteral("baseSize"), 48);
		this->settings->setValue(QStringLiteral("folderBaseName"), QStringLiteral("drawable"));
		this->settings->endGroup();
		//Create "Action Bar / Dialog / Tab"
		this->settings->beginGroup(tr("Action Bar / Dialog / Tab"));
		this->settings->setValue(QStringLiteral("baseSize"), 24);
		this->settings->setValue(QStringLiteral("folderBaseName"), QStringLiteral("drawable"));
		this->settings->endGroup();
		//Create "Context Menu"
		this->settings->beginGroup(tr("Context Menu"));
		this->settings->setValue(QStringLiteral("baseSize"), 16);
		this->settings->setValue(QStringLiteral("folderBaseName"), QStringLiteral("drawable"));
		this->settings->endGroup();
		//Create "Notification"
		this->settings->beginGroup(tr("Notification"));
		this->settings->setValue(QStringLiteral("baseSize"), 22);
		this->settings->setValue(QStringLiteral("folderBaseName"), QStringLiteral("drawable"));
		this->settings->endGroup();
	}
	this->settings->endGroup();

	ui->setupUi(this);
	this->ui->basePathEdit->setDefaultDirectory(QStandardPaths::writableLocation(QStandardPaths::PicturesLocation));
	this->ui->basePathEdit->setPath(this->settings->value(QStringLiteral("paths/savePath")).toString());
	this->ui->tabWidget->setCurrentIndex(0);

	//restore gui
	this->settings->beginGroup(QStringLiteral("gui"));
	this->restoreGeometry(this->settings->value(QStringLiteral("geom")).toByteArray());
	this->restoreState(this->settings->value(QStringLiteral("state")).toByteArray());
	this->ui->loadViewTreeWidget->header()->restoreState(this->settings->value(QStringLiteral("header")).toByteArray());
	this->settings->endGroup();
}

MainWindow::~MainWindow()
{
	//save gui
	this->settings->beginGroup(QStringLiteral("gui"));
	this->settings->setValue(QStringLiteral("geom"), this->saveGeometry());
	this->settings->setValue(QStringLiteral("state"), this->saveState());
	this->settings->setValue(QStringLiteral("header"), this->ui->loadViewTreeWidget->header()->saveState());
	this->settings->endGroup();

	this->settings->sync();
	delete ui;
}

void MainWindow::on_loadButton_clicked()
{
	QString path = QFileDialog::getOpenFileName(this,
												tr("Open Icon Archive"),
												this->settings->value(QStringLiteral("paths/openPath")).toString(),
												tr("Icon files (*.ico *.icns);;Image Files (*.png *.jpg *.bmp);;All Files (*)"));
	if(!path.isEmpty()) {
		this->mainIcon = QIcon(path);
		if(!this->mainIcon.isNull()) {
			this->settings->setValue(QStringLiteral("paths/openPath"), path);
			this->ui->createButton->setEnabled(true);
			this->ui->loadViewTreeWidget->clear();
			this->ui->realFileLineEdit->setText(QFileInfo(path).baseName());

			for(QSize realSize : this->mainIcon.availableSizes()) {
				QTreeWidgetItem *item = new QTreeWidgetItem(this->ui->loadViewTreeWidget);
				QPixmap pixmap = this->mainIcon.pixmap(realSize);
				item->setIcon(0, pixmap);
				item->setText(1, tr("%1x%2").arg(realSize.width()).arg(realSize.height()));
				item->setData(0, Qt::UserRole, pixmap);
			}
		} else {
			QMessageBox::critical(this, tr("Error"), tr("Unable to open icon \"%1\"").arg(path));
		}
	}
}

void MainWindow::on_loadViewTreeWidget_itemDoubleClicked(QTreeWidgetItem *item, int)
{
	if(item)
		this->previewDialog->previewIcon(item->data(0, Qt::UserRole).value<QPixmap>());
}

void MainWindow::on_iconTypeComboBox_activated(const QString &textName)
{
	this->settings->beginGroup(QStringLiteral("templates"));
	this->settings->beginGroup(textName);

	this->ui->baseSizeMdpiSpinBox->setValue(this->settings->value(QStringLiteral("baseSize")).toInt());
	this->ui->contentFolderComboBox->setCurrentText(this->settings->value(QStringLiteral("folderBaseName")).toString());

	this->settings->endGroup();
	this->settings->endGroup();
}

void MainWindow::on_createButton_clicked()
{
	QString pathBase = this->ui->basePathEdit->path();
	QString subFolder = this->ui->contentFolderComboBox->currentText();
	QString realName = this->ui->realFileLineEdit->text();
	if(pathBase.isEmpty() || subFolder.isEmpty() || realName.isEmpty()) {
		QMessageBox::warning(this, tr("Warning"), tr("Please enter a valid base path, folder base and file name"));
		return;
	}

	this->settings->setValue(QStringLiteral("paths/savePath"), pathBase);
	this->settings->beginGroup(this->ui->iconTypeComboBox->currentText());
	this->settings->setValue(QStringLiteral("baseSize"), this->ui->baseSizeMdpiSpinBox->value());
	this->settings->setValue(QStringLiteral("folderBaseName"), this->ui->contentFolderComboBox->currentText());
	this->settings->endGroup();

	QSize baseSize = {this->ui->baseSizeMdpiSpinBox->value(), this->ui->baseSizeMdpiSpinBox->value()};
	QVector<ScaleInfo> checkMap = {
		{this->ui->ldpiCheckBox->isChecked(), QStringLiteral("-ldpi"), 0.5},
		{this->ui->mdpiCheckBox->isChecked(), QStringLiteral("-mdpi"), 1.0},
		{this->ui->hdpiCheckBox->isChecked(), QStringLiteral("-hdpi"), 1.5},
		{this->ui->xhdpiCheckBox->isChecked(), QStringLiteral("-xhdpi"), 2.0},
		{this->ui->xxhdpiCheckBox->isChecked(), QStringLiteral("-xxhdpi"), 3.0},
		{this->ui->xxxhdpiCheckBox->isChecked(), QStringLiteral("-xxxhdpi"), 4.0}
	};
	for(int i = 0; i < 6; ++i) {
		if(checkMap[i].isChecked) {
			//create filepath
			QDir targetDir(pathBase);
			QString fullSubFolder = subFolder + checkMap[i].subFolderSuffix;
			if(!targetDir.mkpath(fullSubFolder)) {
				QMessageBox::critical(this, tr("Error"), tr("Failed to create subfolder \"%1\"").arg(fullSubFolder));
				return;
			}
			targetDir.cd(fullSubFolder);

			QSize realSize = baseSize * checkMap[i].scaleFactor;
			QPixmap targetPix = this->mainIcon.pixmap(realSize);
			if(targetPix.size() != realSize)
				targetPix = targetPix.scaled(realSize, Qt::KeepAspectRatio, Qt::SmoothTransformation);

			QString finalPath = targetDir.absoluteFilePath(realName + QStringLiteral(".png"));
			if(!targetPix.save(finalPath, "png")) {
				QMessageBox::critical(this, tr("Error"), tr("Failed to create file \"%1\"").arg(finalPath));
				return;
			}
		}
	}

	QMessageBox::information(this, tr("Success"), tr("Icons successfully exported!"));
}
