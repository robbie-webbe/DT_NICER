#!/bin/sh

export obsid="$1"
echo $obsid

export orbfile="$obsid"/auxil/ni"$obsid".orb

ls "$obsid"/xti/event_uf/ni*_uf.evt > evtfiles.lis
nimpumerge infiles=@evtfiles.lis outfile="$obsid"/PROC/ni"$obsid"_merge_prebc.evt
rm evtfiles.lis

barycorr infile="$obsid"/PROC/ni"$obsid"_merge_prebc.evt outfile="$obsid"/PROC/ni"$obsid"_uf_bc.evt orbitfiles=$orbfile refframe=ICRS clobber=yes

rm "$obsid"/PROC/ni"$obsid"_merge_prebc.evt

fdelhdu "$obsid"/PROC/ni"$obsid"_uf_bc.evt+9 N Y
fdelhdu "$obsid"/PROC/ni"$obsid"_uf_bc.evt+8 N Y
fdelhdu "$obsid"/PROC/ni"$obsid"_uf_bc.evt+7 N Y
fdelhdu "$obsid"/PROC/ni"$obsid"_uf_bc.evt+6 N Y
fdelhdu "$obsid"/PROC/ni"$obsid"_uf_bc.evt+5 N Y
fdelhdu "$obsid"/PROC/ni"$obsid"_uf_bc.evt+4 N Y
fdelhdu "$obsid"/PROC/ni"$obsid"_uf_bc.evt+3 N Y
fdelhdu "$obsid"/PROC/ni"$obsid"_uf_bc.evt+2 N Y

#remove un-needed columns
fdelcol "$obsid"/PROC/ni"$obsid"_uf_bc.evt+1 RAWX N Y
echo "RAWX deleted. (1/6)"
fdelcol "$obsid"/PROC/ni"$obsid"_uf_bc.evt+1 RAWY N Y
echo "RAWY deleted. (2/6)"
fdelcol "$obsid"/PROC/ni"$obsid"_uf_bc.evt+1 PHA N Y
echo "PHA_FAST deleted. (3/6)"
fdelcol "$obsid"/PROC/ni"$obsid"_uf_bc.evt+1 PHA_FAST N Y
echo "PHA_FAST deleted. (4/6)"
fdelcol "$obsid"/PROC/ni"$obsid"_uf_bc.evt+1 EVENT_FLAGS N Y
echo "EVENT_FLAGS deleted. (5/6)"
fdelcol "$obsid"/PROC/ni"$obsid"_uf_bc.evt+1 TICK N Y
echo "TICK deleted. (6/6)"
