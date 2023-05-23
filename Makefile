all: FETCH BUILD
FETCH:
	time bash fetch.sh 2>&1 | tee fetch.log
BUILD:
	time bash build.sh with-no-env 2>&1 | tee build.log
clean:
	time bash build.sh clean
	rm -f _* ,* *.log
ci:
	mkdir -p RCS
	ci -l -m/dev/null -t/dev/null -q *.sh Makefile
