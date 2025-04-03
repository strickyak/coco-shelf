# Make a NekotOS zip file
set -eux

cd $(dirname $(dirname $0))

N=nekot-coco-microkernel/build-for-16k-bonobo/
TS=$(date +%Y-%m-%d-%H%M%S)
D="nebo-$TS"
Z="nebo-$TS.zip"
HASH=$(cat $N/_nekot1.decb.hash)

mkdir "$D"
cp -fv lib/bonobo.uf2      "$D"
cp -fv bin/tether          "$D"
cp -fv bin/mcp-bonobo-only "$D"

for g in $N/*.game
do
    b=$(basename $g .game)
    cp -fv  $g  "$D/$b.$HASH.game"
done

mkdir "$D/debug-files"
cp -afv nekot-coco-microkernel/build-* "$D/debug-files"

C=nekot-coco-microkernel/build-for-16k-cocoio/
HASH=$(cat $C/_nekot1.decb.hash)
mkdir "$D/cocoio-serving"
mkdir "$D/cocoio-serving/LEMMINGS"
cp -fv $C/_nekot1.decb "$D/cocoio-serving/LEMMINGS/test98.lem"
cp -fv $C/_nekot1.decb "$D/cocoio-serving/LEMMINGS/nekotos-cocoio.lem"
mkdir "$D/cocoio-serving/GAMES"
for g in $C/*.game
do
    b=$(basename $g .game)
    cp -fv  $g  "$D/cocoio-serving/GAMES/$b.$HASH.game"
done

zip -r $Z $D
ls -l $Z
