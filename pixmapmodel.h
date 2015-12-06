#ifndef PIXMAPMODEL_H
#define PIXMAPMODEL_H

#include <QAbstractListModel>
#include <QList>
#include <QPixmap>
#include <QIcon>

class PixmapModel : public QAbstractListModel
{
	Q_OBJECT
public:
	explicit PixmapModel(QObject *parent = 0);

	QPixmap pixmap(const QModelIndex &index) const;
	inline QPixmap pixmap(int index) const;
	QString path(const QModelIndex &index) const;
	inline QString path(int index) const;

	QPixmap findBestPixmap(const QSize &size);

	// QAbstractItemModel interface
	int rowCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
	QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;
	bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex()) Q_DECL_OVERRIDE;
	bool moveRows(const QModelIndex &sourceParent, int sourceRow, int count, const QModelIndex &destinationParent, int destinationChild) Q_DECL_OVERRIDE;

	inline bool moveRows(int from, int count, int to);
	inline bool moveRow(int from, int to);

public slots:
	void insertPixmap(int index, const QPixmap &pixmap, const QString &path = QString());
	inline void appendPixmap(const QPixmap &pixmap, const QString &path = QString());

	void insertIcon(int index, const QIcon &icon, const QString &path = QString());
	inline void appendIcon(const QIcon &icon, const QString &path = QString());

	void reset();

signals:
	void rowsChanged(int count);

private:
	typedef QPair<QPixmap, QString> ContentItem;
	QList<ContentItem> pixmapList;
};



QPixmap PixmapModel::pixmap(int index) const {
	return this->pixmap(this->index(index));
}

QString PixmapModel::path(int index) const {
	return this->path(this->index(index));
}

bool PixmapModel::moveRows(int from, int count, int to) {
	return this->moveRows(QModelIndex(), from, count, QModelIndex(), to);
}

bool PixmapModel::moveRow(int from, int to) {
	return this->moveRows(QModelIndex(), from, 1, QModelIndex(), to);
}

void PixmapModel::appendPixmap(const QPixmap &pixmap, const QString &path) {
	this->insertPixmap(-1, pixmap, path);
}

void PixmapModel::appendIcon(const QIcon &icon, const QString &path) {
	this->insertIcon(-1, icon, path);
}

#endif // PIXMAPMODEL_H
