QX10_takePicture
====
PQI Air Penを使ってSony DSC-QX10のシャッターを切るテスト。

* ![Fig.1](http://farm3.staticflickr.com/2817/10797566114_c9349c7320_n.jpg)

参考URL
====
* [RICOH THETA HACKS! - 物理リモートシャッターをつくる (Building physical THETA remote Controller) - MobileHackerz](http://mobilehackerz.jp/contents/Review/RICOH_THETA/Remote)
* [ひとりぶろぐ » ポケット無線LANルータの新顔PQI Air Penの著しく間違った使い方](http://hitoriblog.com/?p=15926)

簡単な使い方
===
[RICOH THETA HACKS! - 物理リモートシャッターをつくる (Building physical THETA remote Controller) - MobileHackerz](http://mobilehackerz.jp/contents/Review/RICOH_THETA/Remote)と
ほぼ手順は同じです。

* PQI Air PenとDSC-QX10のWiFi接続の設定をする
  * SSID: DIRECT????:DSC-QX10のAPに接続するように、http://192.168.200.1/ から設定
* PQI Air Penに刺すmicroSDにThetaShutter_PQIAirPen002.zipを展開
* [theta_remote.sh](https://raw.github.com/yoggy/QX10_takePicture/master/theta_remote.sh)と[QX10_takePicture](https://github.com/yoggy/QX10_takePicture/raw/master/QX10_takePicture)をthetaディレクトリにコピーする
* DSC-QX10の電源を先に入れ、次にmicroSDを刺してPQI Air Penを起動
* 起動後30〜40秒後ぐらいに本体横のボタンを押してシャッターが切れれば設定成功


