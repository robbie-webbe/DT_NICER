#!/bin/sh

export obsid="$1"
echo $obsid
mkdir "$obsid"/PROC

gunzip "$obsid"/auxil/*.gz
gunzip "$obsid"/xti/hk/*.gz
gunzip "$obsid"/xti/event_uf/*.gz
gunzip "$obsid"/xti/event_cl/*.gz

nicerl2 indir=$obsid nicercal_filtexpr="EVENT_FLAGS=bxxx000" elv=30 br_earth=40 cor_range="4.0-" underonly_range="0-50" clobber=yes
barycorr infile="$obsid"/xti/event_cl/ni"$obsid"_0mpu7_cl.evt outfile="$obsid"/PROC/xti"$obsid"_0.2-15.0keV.evt orbitfiles="$obsid"/auxil/ni"$obsid".orb 
refframe=ICRS

cd "$obsid"/PROC

#remove un-needed hdus
for i in {30..4}
do
	fdelhdu xti"$obsid"_0.2-15.0keV.evt+"$i" N Y
done

#remove un-needed columns
fdelcol xti"$obsid"_0.2-15.0keV.evt+1 RAWX N Y
fdelcol xti"$obsid"_0.2-15.0keV.evt+1 RAWY N Y
fdelcol xti"$obsid"_0.2-15.0keV.evt+1 PHA N Y
fdelcol xti"$obsid"_0.2-15.0keV.evt+1 TICK N Y
fdelcol xti"$obsid"_0.2-15.0keV.evt+1 PHA_FAST N Y
fdelcol xti"$obsid"_0.2-15.0keV.evt+1 EVENT_FLAGS N Y
fdelcol xti"$obsid"_0.2-15.0keV.evt+1 MPU_A_TEMP N Y
fdelcol xti"$obsid"_0.2-15.0keV.evt+1 MPU_UNDER_COUNT N Y
fdelcol xti"$obsid"_0.2-15.0keV.evt+1 PI_FAST N Y
fdelcol xti"$obsid"_0.2-15.0keV.evt+1 PI_RATIO N Y

cd ..
cd ..
