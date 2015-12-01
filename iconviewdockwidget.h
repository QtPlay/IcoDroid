#ifndef ICONVIEWDOCKWIDGET_H
#define ICONVIEWDOCKWIDGET_H

#include <QDockWidget>

namespace Ui {
class IconViewDockWidget;
}

class IconViewDockWidget : public QDockWidget
{
	Q_OBJECT

public:
	explicit IconViewDockWidget(QWidget *parent = 0);
	~IconViewDockWidget();

	void setPreviewIcon(const QPixmap &pixmap);

private:
	Ui::IconViewDockWidget *ui;
};

#endif // ICONVIEWDOCKWIDGET_H
