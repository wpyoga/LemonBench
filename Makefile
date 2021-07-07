SPLIT_SCRIPTS = \
	LemonBench-split.sh \
	init/*.sh \
	components/*.sh \
	systeminfo/*.sh \
	mediaunlock/*.sh \

all: LemonBench-merged.sh

LemonBench-merged.sh: $(SPLIT_SCRIPTS)
	merge-shell LemonBench-split.sh > LemonBench-merged.sh
	[ "`tail -c 1 LemonBench-merged.sh`" = "`echo`" ] && truncate -s -1 LemonBench-merged.sh

test: LemonBench-merged.sh
	@diff -u LemonBench.sh LemonBench-merged.sh
	@echo "Test passed"

clean:
	rm -f LemonBench-merged.sh
