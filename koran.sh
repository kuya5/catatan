#!/bin/bash
#Kompas ePaper Downloader
#by: Ardianto Satriawan

#need wget and imagemagick
#sudo apt-get install wget imagemagick

#get today's date
TODAY=$(date +%d-%b-%Y)
YEAR=$(date +%Y)
TODAYURL=$(date +%d%m%y)
TODAYFOLDER=$(date +%Y/%m/%d)
TODAYFILE=$(date +%d_%m_%Y)
MONTH=$(date +%B)

#create todays directory
mkdir $TODAY

#wget for jpg
PAGE=1
until [ $PAGE -gt 9 ]; do 
	wget "http://images.cdn.realviewdigital.com/djvu/Kompas/Kompas/"$TODAY"/webimages/page000000"$PAGE"_large.jpg"
	let PAGE+=1
done
PAGE=10
until [ $PAGE -gt 44 ]; do 
	wget "http://images.cdn.realviewdigital.com/djvu/Kompas/Kompas/"$TODAY"/webimages/page00000"$PAGE"_large.jpg"
	let PAGE=PAGE+1
done

#wget for png
PAGE=1
until [ $PAGE -gt 9 ]; do 
	wget "http://images.cdn.realviewdigital.com/djvu/Kompas/Kompas/"$TODAY"/webimages/page000000"$PAGE"_large.png"
	let PAGE+=1
done
PAGE=10
until [ $PAGE -gt 44 ]; do 
	wget "http://images.cdn.realviewdigital.com/djvu/Kompas/Kompas/"$TODAY"/webimages/page00000"$PAGE"_large.png"
	let PAGE+=1
done

#move to today's directory
mv ./*.jpg ./$TODAY
mv ./*.png ./$TODAY

#combine PNGs with JPEGs
echo "combining raw files..."
PAGE=1
until [ $PAGE -gt 9 ]; do
	composite -gravity center "./"$TODAY"/page000000"$PAGE"_large.png" "./"$TODAY"/page000000"$PAGE"_large.jpg" "./"$TODAY"/page0"$PAGE".jpg"
	echo "page "$PAGE" done!"
	let PAGE+=1
done
PAGE=10
until [ $PAGE -gt 44 ]; do
	composite -gravity center "./"$TODAY"/page00000"$PAGE"_large.png" "./"$TODAY"/page00000"$PAGE"_large.jpg" "./"$TODAY"/page"$PAGE".jpg"
	echo "page "$PAGE" done!"
	let PAGE+=1
done

#removing raw files
echo "removing raw files..."
rm ./$TODAY/*large.jpg
rm ./$TODAY/*large.png
echo "done"

#converting into PDFs
echo "converting into PDF"
convert ./$TODAY/*.jpg ./$TODAY/Kompas-$TODAY.pdf
echo "done"

#removing JPEGs
echo "removing JPEGs"
rm ./$TODAY/*.jpg

#English to Indonesian month translation
if [ $MONTH = "January" ]; then
	BULAN="Januari"
else
	if [ $MONTH = "February" ]; then
		BULAN="Februari"
	else
		if [ $MONTH = "March" ]; then
			BULAN="Maret"
		else
			if [ $MONTH = "April" ]; then
				BULAN="April"
			else
				if [ $MONTH = "May" ]; then
					BULAN="Mei"
				else
					if [ $MONTH = "June" ]; then
						BULAN="Juni"
					else
						if [ $MONTH = "July" ]; then
							BULAN="Juli"
						else
							if [ $MONTH = "August" ]; then
								BULAN="Agustus"
							else
								if [ $MONTH = "September" ]; then
									BULAN="September"
								else
									if [ $MONTH = "October" ]; then
										BULAN="Oktober"
									else
										if [ $MONTH = "November" ]; then
											BULAN="November"
										else
											BULAN="Desember"
										fi
									fi
								fi
							fi
						fi
					fi
				fi
			fi
		fi
	fi
fi

#echo $BULAN

#create directory

#getting JPEGs
PAGE=1
until [ $PAGE -gt 9 ]; do
	wget "http://epaper.pikiran-rakyat.com/images/flippingbook/PR/"$YEAR"/"$MONTH"/"$TODAYURL"/"$TODAYURL"_zoom_0"$PAGE".jpg"
	let PAGE+=1
done
PAGE=10
until [ $PAGE -gt 40 ]; do
	wget "http://epaper.pikiran-rakyat.com/images/flippingbook/PR/"$YEAR"/"$MONTH"/"$TODAYURL"/"$TODAYURL"_zoom_"$PAGE".jpg"
	let PAGE+=1
done

#moving into today's directory
mv ./*.jpg ./$TODAY

#converting JPEGs into PDFs
convert ./$TODAY/*.jpg ./$TODAY/PikiranRakyat-$TODAY.pdf

#remove JPEGs
rm ./$TODAY/*.jpg

#get each page
PAGE=1
until [ $PAGE -gt 9 ]; do
	wget "http://epaper.korantempo.com/KT/KT/"$TODAYFOLDER"/PagePrint/"$TODAYFILE"_00"$PAGE".pdf"
	let PAGE+=1
done
PAGE=10
until [ $PAGE -gt 32 ]; do
	wget "http://epaper.korantempo.com/KT/KT/"$TODAYFOLDER"/PagePrint/"$TODAYFILE"_0"$PAGE".pdf"
	let PAGE+=1
done

#move to today's directory
mv ./*.pdf ./$TODAY

#merge the PDFs
gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=./$TODAY/KoranTempo-$TODAY.pdf -dBATCH ./$TODAY/$TODAYFILE*.pdf

#remove PDFs
rm ./$TODAY/$TODAYFILE*.pdf


#get each page
PAGE=1
until [ $PAGE -gt 9 ]; do
	wget "http://anax1a.pressmart.net/mediaindonesia/MI/MI/"$TODAYFOLDER"/PagePrint/"$TODAYFILE"_00"$PAGE".pdf"
	let PAGE+=1
done
PAGE=10
until [ $PAGE -gt 32 ]; do
	wget "http://anax1a.pressmart.net/mediaindonesia/MI/MI/"$TODAYFOLDER"/PagePrint/"$TODAYFILE"_0"$PAGE".pdf"
	let PAGE+=1
done

#move to today's directory
mv ./*.pdf ./$TODAY

#merge the PDFs
gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=./$TODAY/MediaIndonesia-$TODAY.pdf -dBATCH ./$TODAY/$TODAYFILE*.pdf

#remove PDFs
rm ./$TODAY/$TODAYFILE*.pdf

#get each page
PAGE=1
until [ $PAGE -gt 9 ]; do
	wget "http://mcetak.suaramerdeka.com/PUBLICATIONS//SM/SM/"$TODAYFOLDER"/PagePrint/"$TODAYFILE"_00"$PAGE".pdf"
	let PAGE+=1
done
PAGE=10
until [ $PAGE -gt 32 ]; do
	wget "http://mcetak.suaramerdeka.com/PUBLICATIONS//SM/SM/"$TODAYFOLDER"/PagePrint/"$TODAYFILE"_0"$PAGE".pdf"
	let PAGE+=1
done


#move to today's directory
mv ./*.pdf ./$TODAY

#merge the PDFs
gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=./$TODAY/Suaramerdeka-$TODAY.pdf -dBATCH ./$TODAY/$TODAYFILE*.pdf

#remove PDFs
rm ./$TODAY/$TODAYFILE*.pdf

#get each page
PAGE=1
until [ $PAGE -gt 9 ]; do
	wget "http://epaper.bisnis.com/PUBLICATIONS/BISNISINDONESIA/BI/"$TODAYFOLDER"/PagePrint/"$TODAYFILE"_00"$PAGE".pdf"
	let PAGE+=1
done
PAGE=10
until [ $PAGE -gt 32 ]; do
	wget "http://epaper.bisnis.com/PUBLICATIONS/BISNISINDONESIA/BI/"$TODAYFOLDER"/PagePrint/"$TODAYFILE"_0"$PAGE".pdf"
	let PAGE+=1
done


#move to today's directory
mv ./*.pdf ./$TODAY

#merge the PDFs
gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=./$TODAY/BisnisIndonesia-$TODAY.pdf -dBATCH ./$TODAY/$TODAYFILE*.pdf


#remove PDFs
rm ./$TODAY/$TODAYFILE*.pdf

