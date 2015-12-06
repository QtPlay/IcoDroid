#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QSettings>
#include <QListWidgetItem>
#include "iconviewdockwidget.h"
#include "pixmapmodel.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
	Q_OBJECT

public:
	explicit MainWindow(QWidget *parent = 0);
	~MainWindow();

public slots:
	void openFile(QString path);

private slots:
	void rowsChanged(int count);
	void selectionChanged(const QModelIndex &current);

	void on_actionAdd_File_triggered();
	void on_actionRemove_triggered();
	void on_iconTypeComboBox_activated(const QString &textName);
	void on_createButton_clicked();

private /*functions*/:
	void initSettings();

	QString stripSlash(QString base);

private:
	Ui::MainWindow *ui;
	QSettings *settings;
	PixmapModel *mainModel;
	IconViewDockWidget *previewDock;
};

#endif // MAINWINDOW_H
