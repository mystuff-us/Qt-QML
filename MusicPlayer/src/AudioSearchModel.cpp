#include "AudioSearchModel.h"
#include "AudioInfo.h"
#include <QJsonDocument>
#include <QNetworkReply>
#include <QUrlQuery>
#include <QJsonObject>
#include <QJsonArray>

namespace {
const QString &k_requestUrl = "https://api.jamendo.com/v3.0/tracks/";
const QString &k_clientId = "c29bf70d";//"85b6a59c";
}

AudioSearchModel::AudioSearchModel(QObject *parent)
		: QAbstractListModel(parent)
{
}

int AudioSearchModel::rowCount(const QModelIndex &parent) const
{
	Q_UNUSED(parent);
	return m_audioList.size();
}

QVariant AudioSearchModel::data(const QModelIndex &index, int role) const
{
	if (index.isValid() && index.row() >= 0 && index.row() < m_audioList.size()) {
		AudioInfo *audioInfo = m_audioList[index.row()];

		switch((Role)role) {
		case AudioNameRole:
			return audioInfo->title();
		case AudioAuthorRole:
			return audioInfo->authorName();
		case AudioImageSourceRole:
			return audioInfo->imageSource();
		case AudioSourceRole:
			return audioInfo->audioSource();
		}
	}

	return {};
}

QHash<int, QByteArray> AudioSearchModel::roleNames() const
{
	QHash<int, QByteArray> names;

	names[AudioNameRole] = "audioName";
	names[AudioAuthorRole] = "audioAuthor";
	names[AudioImageSourceRole] = "audioImageSource";
	names[AudioSourceRole] = "audioSource";

	return names;
}

void AudioSearchModel::searchSong(const QString &name)
{
	if (!name.trimmed().isEmpty()) {
		if (m_reply) {
			m_reply->abort();
			m_reply->deleteLater();
			m_reply = nullptr;
		}

		// See Jamendo.com for syntax
		QUrlQuery query;
		query.addQueryItem("client_id", k_clientId);
		query.addQueryItem("namesearch", name);
		query.addQueryItem("format", "json");

		setIsSearching(true);
		m_reply = m_networkManager.get(QNetworkRequest(k_requestUrl + "?" + query.toString()));
		connect(m_reply, &QNetworkReply::finished, this, &AudioSearchModel::parseData);
	}
}

void AudioSearchModel::parseData()
{
	if (m_reply->error() == QNetworkReply::NoError) {
		beginResetModel();

		qDeleteAll(m_audioList);
		m_audioList.clear();

		QByteArray data = m_reply->readAll();

		// See:
		//  https://developer.jamendo.com/v3.0/tracks
		// {
		//   "headers":{
		//     "status":"success",
		//     "code":0,
		//     "error_message":"",
		//     "warnings":"",
		//     "results_count":2
		//   },
		//   "results":[
		//     {
		//       "id":"1532771",
		//       "name":"Let Me Hear You I",
		//       "duration":54,
		//       "artist_id":"461414",
		//       "artist_name":"Paul Werner",
		//       "artist_idstr":"PaulWernerMusic",
		//       "album_name":"Let Me Hear You I",
		//       "album_id":"404140",
		//       "license_ccurl":"http:\/\/creativecommons.org\/licenses\/by-nc-nd\/3.0\/",
		//       "position":1,
		//       "releasedate":"2018-03-15",
		//       "album_image":"https:\/\/usercontent.jamendo.com?type=album&id=404140&width=300&trackid=1532771",
		//       "audio":"https:\/\/prod-1.storage.jamendo.com\/?trackid=1532771&format=mp31&from=app-devsite",
		//       "audiodownload":"https:\/\/prod-1.storage.jamendo.com\/download\/track\/1532771\/mp32\/",
		//       ...
		//     "image":"https:\/\/usercontent.jamendo.com?type=album&id=404140&width=300&trackid=1532771",
		//               "musicinfo":{
		//                   "vocalinstrumental":"instrumental",
		//                   "lang":"",
		//                   "gender":"",
		//                   "acousticelectric":"",
		//                   "speed":"high",
		//                   "tags":{
		//                       "genres":[
		//                           "funk",
		//                           "pop"
		//                       ],
		//                       "instruments":[

		//     ],
		//                       "vartags":[
		//                           "groovy"
		//     ]
		//                   }
		//               },
		//                             "audiodownload_allowed":true
		// },
		// ...

		// Convert 'data' into JSON format
		QJsonDocument jsonDocument = QJsonDocument::fromJson(data);
		QJsonObject headers = jsonDocument["headers"].toObject();

		// Did the return value suceed?
		if (headers["status"].toString() == "success") {
			QJsonArray results = jsonDocument["results"].toArray();

			for (const auto &result : results) {
				QJsonObject entry = result.toObject();

				// Can we download the file? (required)
				if (entry["audiodownload_allowed"].toBool()) {
					AudioInfo *audioInfo = new AudioInfo(this);

					// Populate 'audioInfo' from JSON values.
					audioInfo->setTitle(entry["name"].toString());
					audioInfo->setAuthorName(entry["artist_name"].toString());
					audioInfo->setImageSource(entry["image"].toString());
					audioInfo->setAudioSource(entry["audiodownload"].toString());

					// Append to list
					m_audioList << audioInfo;
				}
			}
		} else {
			qWarning() << headers["error_string"];
		}

		endResetModel();
	} else if (m_reply->error() != QNetworkReply::OperationCanceledError) {
		qCritical() << "Reply failed, error:" << m_reply->errorString();
	}

	setIsSearching(false);
	m_reply->deleteLater();
	m_reply = nullptr;
}

bool AudioSearchModel::isSearching() const
{
	return m_isSearching;
}

void AudioSearchModel::setIsSearching(bool newIsSearching)
{
	if (m_isSearching == newIsSearching)
		return;
	m_isSearching = newIsSearching;
	emit isSearchingChanged();
}
