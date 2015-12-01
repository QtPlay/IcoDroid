#ifndef ICONVIEWDIALOG_H
#define ICONVIEWDIALOG_H

#include <QDialog>

namespace Ui {
class IconViewDialog;
}

class IconViewDialog : public QDialog
{
	Q_OBJECT

public:
	explicit IconViewDialog(QWidget *parent = 0);
	~IconViewDialog();

	void previewIcon(const QPixmap &pixmap);

private:
	Ui::IconViewDialog *ui;
};

#endif // ICONVIEWDIALOG_H
