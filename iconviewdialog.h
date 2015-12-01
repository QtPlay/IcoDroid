#ifndef ICONVIEWDIALOG_H
#define ICONVIEWDIALOG_H

#include <QDialog>
#include <QSettings>

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
	QSettings *settings;
};

#endif // ICONVIEWDIALOG_H
