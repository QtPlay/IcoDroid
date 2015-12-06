#include <QTranslator>
#include "mainwindow.h"
#include <QApplication>
#include <QLibraryInfo>
#include <QLocale>
#include <QCommandLineParser>
#include <QMessageBox>

static bool execParser(QCommandLineParser &parser);

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
	if(!execParser(parser))
		return 0;

	//TODO use the paths passed command line
	MainWindow w;

	for(QString path : parser.positionalArguments())
		w.openFile(path);

	w.show();

	return a.exec();
}

static bool execParser(QCommandLineParser &parser)
{
	parser.setApplicationDescription(QCoreApplication::translate("GLOBAL", "A tool to create Android icons from single files like .ico, .png, …"));
	parser.addHelpOption();

	parser.addPositionalArgument(QCoreApplication::translate("GLOBAL", "Icon Files"),
								 QCoreApplication::translate("GLOBAL", "A number of <paths> to files to be opened by this tool"),
								 "[paths…]");

	if(!parser.parse(QCoreApplication::arguments())) {
		QMessageBox::warning(NULL,
							 QCoreApplication::translate("GLOBAL", "Invalid arguments!"),
							 parser.errorText());
		return false;
	} else {
		if(parser.isSet(QStringLiteral("h"))) {
			QMessageBox::information(NULL,
									 QCoreApplication::translate("GLOBAL", "Usage"),
									 parser.helpText());
			return false;
		}

		return true;
	}
}
