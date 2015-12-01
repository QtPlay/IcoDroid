#include "iconviewdialog.h"
#include "ui_iconviewdialog.h"

IconViewDialog::IconViewDialog(QWidget *parent) :
	QDialog(parent, Qt::WindowCloseButtonHint | Qt::MSWindowsFixedSizeDialogHint),
	ui(new Ui::IconViewDialog),
	settings(new QSettings(this))
{
	ui->setupUi(this);

	this->settings->beginGroup(QStringLiteral("gui"));
	this->restoreGeometry(this->settings->value(QStringLiteral("previewGeom")).toByteArray());
}

IconViewDialog::~IconViewDialog()
{
	this->settings->setValue(QStringLiteral("previewGeom"), this->saveGeometry());
	delete ui;
}

void IconViewDialog::previewIcon(const QPixmap &pixmap)
{
	this->ui->label->setPixmap(pixmap);
	this->setWindowIcon(pixmap);
	this->adjustSize();
	this->show();
}
