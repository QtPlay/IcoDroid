#include "iconviewdialog.h"
#include "ui_iconviewdialog.h"

IconViewDialog::IconViewDialog(QWidget *parent) :
	QDialog(parent, Qt::WindowCloseButtonHint | Qt::MSWindowsFixedSizeDialogHint),
	ui(new Ui::IconViewDialog)
{
	ui->setupUi(this);
}

IconViewDialog::~IconViewDialog()
{
	delete ui;
}

void IconViewDialog::previewIcon(const QPixmap &pixmap)
{
	this->ui->label->setPixmap(pixmap);
	this->adjustSize();
	this->show();
}
