# Make a NekotOS zip file
set -eux

cd $(dirname $(dirname $0))

N=nekotos/build-for-16k-bonobo/
TS=$(date +%Y-%m-%d-%H%M%S)
D="nebo-$TS"
Z="nebo-$TS.zip"
HASH=$(cat $N/_kernel.decb.hash)

mkdir "$D"
cp -fv scripts/make-nebo-release.README.txt "$D/README.txt"
cp -fv lib/bonobo.uf2      "$D"
cp -fv bin/tether          "$D"
cp -fv bin/mcp-bonobo-only "$D"

for g in $N/*.game
do
    b=$(basename $g .game)
    cp -fv  $g  "$D/$b.$HASH.game"
done
# TODO: Why both names?
cp -fv  $N/_kernel.decb  "$D/kernel.bonobo-nekotos.decb"
cp -fv  $N/_kernel.decb  "$D/kernel.for-16k-bonobo.decb"

mkdir "$D/debug-files"
cp -afv nekotos/build-* "$D/debug-files"

C=nekotos/build-for-16k-cocoio/
HASH=$(cat $C/_kernel.decb.hash)
mkdir "$D/cocoio-serving"
mkdir "$D/cocoio-serving/LEMMINGS"
cp -fv $C/_kernel.decb "$D/cocoio-serving/LEMMINGS/test98.lem"
cp -fv $C/_kernel.decb "$D/cocoio-serving/LEMMINGS/nekotos-cocoio.lem"
mkdir "$D/cocoio-serving/GAMES"
for g in $C/*.game
do
    b=$(basename $g .game)
    cp -fv  $g  "$D/cocoio-serving/GAMES/$b.$HASH.game"
done

zip -r $Z $D
ls -l $Z
