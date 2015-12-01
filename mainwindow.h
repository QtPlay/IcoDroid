#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QSettings>
#include <QListWidgetItem>
#include "iconviewdialog.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
	Q_OBJECT

public:
	explicit MainWindow(QWidget *parent = 0);
	~MainWindow();

private slots:
	void on_loadButton_clicked();
	void on_loadViewListWidget_itemDoubleClicked(QListWidgetItem *item);

	void on_iconTypeComboBox_activated(const QString &textName);

	void on_createButton_clicked();

private:
	Ui::MainWindow *ui;
	QSettings *settings;
	IconViewDialog *previewDialog;

	QIcon mainIcon;
};

#endif // MAINWINDOW_H
