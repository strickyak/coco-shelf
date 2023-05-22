all:
	time bash build.sh with-no-env 2>&1 | tee /tmp/build.log
clean:
	time bash build.sh clean
ci:
	mkdir -p RCS
	ci -l -m/dev/null -t/dev/null -q *.sh Makefile
