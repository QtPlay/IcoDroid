#include "pixmapmodel.h"

PixmapModel::PixmapModel(QObject *parent) :
	QAbstractListModel(parent),
	pixmapList()
{}

QPixmap PixmapModel::pixmap(const QModelIndex &index) const
{
	if(index.row() < 0 ||
	   index.row() >= this->pixmapList.size() ||
	   index.column() != 0 ||
	   index.parent().isValid()) {
		return QPixmap();
	} else
		return this->pixmapList[index.row()].first;
}

QString PixmapModel::path(const QModelIndex &index) const
{
	if(index.row() < 0 ||
	   index.row() >= this->pixmapList.size() ||
	   index.column() != 0 ||
	   index.parent().isValid()) {
		return QString();
	} else
		return this->pixmapList[index.row()].second;
}

QPixmap PixmapModel::findBestPixmap(const QSize &size)
{
	if(this->pixmapList.isEmpty())
		return QPixmap();

//	QPixmap bestMatch;
//	for(ContentItem item : this->pixmapList) {
//		QSize pixSize = {item.first.width(), item.first.height()};
//		if(pixSize.width() >= size.width() &&
//		   pixSize.height() >= size.height()) {
//			if(bestMatch.isNull())
//				bestMatch = item.first;
//			else {
//				if(pixSize.height() < bestMatch.height())
//					bestMatch = item.first;
//				else if(pixSize.width() < bestMatch.width())
//					bestMatch = item.first;
//			}
//		}
//	}

	QIcon resolverIcon;
	for(ContentItem item : this->pixmapList) {
		resolverIcon.addPixmap(item.second);
	}

	return resolverIcon.pixmap(size).scaled(size, Qt::KeepAspectRatio, Qt::SmoothTransformation);
}

int PixmapModel::rowCount(const QModelIndex &parent) const
{
	if(parent.isValid())
		return 0;
	else
		return this->pixmapList.size();
}

QVariant PixmapModel::data(const QModelIndex &index, int role) const
{
	if(index.row() < 0 ||
	   index.row() >= this->pixmapList.size() ||
	   index.column() != 0 ||
	   index.parent().isValid()) {
		return QVariant();
	}

	switch(role) {
	case Qt::DisplayRole:
		return tr("%1x%2")
				.arg(this->pixmapList[index.row()].first.width())
				.arg(this->pixmapList[index.row()].first.height());
	case Qt::DecorationRole:
		return this->pixmapList[index.row()].first.scaled({16, 16}, Qt::KeepAspectRatio, Qt::SmoothTransformation);
	case Qt::ToolTipRole:
		return tr("From file: ") + this->pixmapList[index.row()].second;
	default:
		return QVariant();
	}
}

bool PixmapModel::removeRows(int row, int count, const QModelIndex &parent)
{
	if(row < 0 ||
	   row + count > this->pixmapList.size() ||
	   parent.isValid()) {
		return false;
	}

	this->beginRemoveRows(parent, row, row + count - 1);
	for(int i = 0; i < count; ++i)
		this->pixmapList.removeAt(row);
	this->endRemoveRows();
	emit rowsChanged(this->pixmapList.size());
	return true;
}

bool PixmapModel::moveRows(const QModelIndex &sourceParent, int sourceRow, int count, const QModelIndex &destinationParent, int destinationChild)
{
	if(sourceRow < 0 ||
	   sourceRow + count > this->pixmapList.size() ||
	   sourceParent.isValid() ||
	   destinationChild < 0 ||
	   destinationChild > this->pixmapList.size() ||
	   destinationParent.isValid()) {
		return false;
	}

	if(this->beginMoveRows(sourceParent, sourceRow, sourceRow + count - 1, destinationParent, destinationChild)) {
		for(int i = 0; i < count; ++i) {
			if(sourceRow > destinationChild)
				this->pixmapList.move(sourceRow + i, destinationChild + i);
			else
				this->pixmapList.move(sourceRow, destinationChild);
		}
		this->endMoveRows();
		return true;
	} else
		return false;
}

void PixmapModel::insertPixmap(int index, const QPixmap &pixmap, const QString &path)
{
	if(index < 0 || index > this->pixmapList.size())
		index = this->pixmapList.size();

	this->beginInsertRows(QModelIndex(), index, index);
	this->pixmapList.insert(index, {pixmap, path});
	this->endInsertRows();
	emit rowsChanged(this->pixmapList.size());
}

void PixmapModel::insertIcon(int index, const QIcon &icon, const QString &path)
{
	if(index < 0 || index > this->pixmapList.size())
		index = this->pixmapList.size();

	QList<QSize> sizes = icon.availableSizes();
	this->beginInsertRows(QModelIndex(), index, index + sizes.size() - 1);
	for(int i = 0, max = sizes.size(); i < max; ++i) {
		this->pixmapList.insert(index + i, {icon.pixmap(sizes[i]), path});
	}
	this->endInsertRows();
	emit rowsChanged(this->pixmapList.size());
}

void PixmapModel::reset()
{
	this->beginResetModel();
	this->pixmapList.clear();
	this->endResetModel();
	emit rowsChanged(this->pixmapList.size());
}
