#include <QTranslator>
#include "mainwindow.h"
#include <QApplication>
#include <QLibraryInfo>
#include <QLocale>
#include <QCommandLineParser>

static void initParser(QCommandLineParser &parser);

int main(int argc, char *argv[])
{
	QApplication a(argc, argv);
	QCoreApplication::setApplicationName(TARGET);
	QCoreApplication::setApplicationVersion(VERSION);
	QCoreApplication::setOrganizationName(COMPANY);
	QCoreApplication::setOrganizationDomain(QStringLiteral("skynet.is-an-engineer.com"));
	QApplication::setApplicationDisplayName(DISPLAY_NAME);
	QApplication::setWindowIcon(QIcon(QStringLiteral(":/icons/main.ico")));

	QTranslator *translator = new QTranslator(qApp);
	if(translator->load(QLocale(),
						QStringLiteral("Icodroid"),
						QStringLiteral("_"),
						QLibraryInfo::location(QLibraryInfo::TranslationsPath),
						QStringLiteral(".qm"))) {
		QCoreApplication::installTranslator(translator);
	}

	MainWindow w;
	w.show();

	return a.exec();
}

static void initParser(QCommandLineParser &parser)
{
	//TODO
}
