all:
	time sh build.sh with-no-env 2>&1 | tee /tmp/build.log
clean:
	time sh build.sh clean
ci:
	mkdir -p RCS
	ci -l -m/dev/null -t/dev/null -q build.sh Makefile
