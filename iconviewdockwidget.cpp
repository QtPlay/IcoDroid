#include "iconviewdockwidget.h"
#include "ui_iconviewdockwidget.h"

IconViewDockWidget::IconViewDockWidget(QWidget *parent) :
	QDockWidget(parent),
	ui(new Ui::IconViewDockWidget)
{
	ui->setupUi(this);
}

IconViewDockWidget::~IconViewDockWidget()
{
	delete ui;
}

void IconViewDockWidget::setPreviewIcon(const QPixmap &pixmap)
{
	this->setMinimumSize(150, 0);
	this->resize(0, 0);
	this->ui->label->setPixmap(pixmap);
}
