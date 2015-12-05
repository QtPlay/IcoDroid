#include <QTranslator>
#include "mainwindow.h"
#include <QApplication>
#include <QLibraryInfo>
#include <QLocale>
#include <QCommandLineParser>
#include <QMessageBox>

static int execParser(QCommandLineParser &parser);

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

	QCommandLineParser parser;
	int parserRes = execParser(parser);
	if(parserRes)
		return parserRes;

	MainWindow w;
	w.show();

	return a.exec();
}

static int execParser(QCommandLineParser &parser)
{
	parser.setApplicationDescription(QCoreApplication::translate("GLOBAL", ""));
	parser.addVersionOption();
	parser.addHelpOption();

	if(!parser.parse(QCoreApplication::arguments())) {
		QMessageBox::warning(NULL, QCoreApplication::translate("GLOBAL", "Invalid arguments!"), parser.errorText());
		return 42;
	} else {
		if(parser.isSet(QStringLiteral("help"))) {
			QMessageBox::information(NULL, QCoreApplication::translate("GLOBAL", "Usage"), parser.helpText());
			return 1;
		}
	}
}
