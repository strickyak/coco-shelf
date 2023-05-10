all:
	time bash build.bash with-no-env 2>&1 | tee /tmp/build.log
clean:
	time bash build.bash clean
ci:
	mkdir -p RCS
	ci -l -m/dev/null -t/dev/null -q build.bash Makefile
