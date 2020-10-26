.SUFFIXES:

LANGUAGES:=clojure dart go haxe java js kotlin nim python ruby scala scheme

all: results

.PHONY: clean
clean:
	rm -f $(addsuffix /results.txt,${LANGUAGES})
	rm -f $(addsuffix /prime.js,$(filter-out js,${LANGUAGES}))

.PHONY: results
results: $(addsuffix /results.txt,${LANGUAGES})

%/results.txt: %/prime.js
	@echo '$$ ${VERSION_COMMAND}' > $@
	echo '$(shell ${VERSION_COMMAND} 2>&1)' >> $@
	@echo '$$ wc -c $< ${COUNTED_FILES}' >> $@
	wc -c $< ${COUNTED_FILES} >> $@
	@echo "$$ hyperfine 'node ${NODE_FLAGS} $<'" >> $@
	hyperfine 'node ${NODE_FLAGS} $<' >> $@

clojure/results.txt: VERSION_COMMAND:=echo "(println (clojure-version))" | clojure -
dart/results.txt: VERSION_COMMAND:=dart --version
go/results.txt: VERSION_COMMAND:=go version && gopherjs version
haxe/results.txt: VERSION_COMMAND:=haxe -version
java/results.txt: VERSION_COMMAND:=(java -version 2>&1) && (cd java && (mvn -o dependency:list | grep jsweet-core))
js/results.txt: VERSION_COMMAND:=node -v
kotlin/results.txt: VERSION_COMMAND:=kotlin -version
kotlin/results.txt: COUNTED_FILES:=kotlin/node_modules/kotlin/kotlin.js
python/results.txt: VERSION_COMMAND:=(transcrypt | grep Transcrypt) && python3 -V
python/results.txt: COUNTED_FILES:=python/__target__/org.transcrypt.__runtime__.mjs
python/results.txt: NODE_FLAGS:=--experimental-modules python/__target__/prime.mjs; echo
nim/results.txt: VERSION_COMMAND:=nim -v
ruby/results.txt: VERSION_COMMAND:=ruby --version && opal --version
scala/results.txt: VERSION_COMMAND:=(sbt scalaVersion sbtVersion | tail -n2 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+'); (cd scala && sbt libraryDependencies | grep -m1 scalajs | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
scheme/results.txt: VERSION_COMMAND:=chicken -version

clojure/prime.js: clojure/src/prime/core.cljs
	cd clojure && clj --main cljs.main --optimizations advanced --compile prime.core
	mv clojure/out/main.js $@

dart/prime.js: dart/prime.dart
	dart2js -O2 -o $@ $<

go/prime.js: go/prime.go
	gopherjs build $< -m -o $@

haxe/prime.js: haxe/Prime.hx
	cd haxe && haxe -js prime.js -main Prime

java/prime.js: java/src/main/java/prime/Prime.java
	cd java && mvn generate-sources
	mv java/target/js/prime/Prime.js $@

kotlin/prime.js: kotlin/prime.kt
	kotlinc-js -output $@ -module-kind commonjs $<

python/prime.js: python/prime.py
	transcrypt $<
	cp python/__target__/prime.js $@
	mv python/__target__/prime.js python/__target__/prime.mjs
	mv python/__target__/org.transcrypt.__runtime__.js python/__target__/org.transcrypt.__runtime__.mjs
	sed -i.bak 's/__runtime__\.js/__runtime__\.mjs/' python/__target__/prime.mjs
	rm -f python/__target__/prime.mjs.bak

nim/prime.js: nim/prime.nim
	nim js -d:nodejs $<
	mv nim/nimcache/prime.js $@

ruby/prime.js: ruby/prime.rb
	opal -c $< > $@

scala/prime.js: scala/src/main/scala/Prime.scala
	cd scala && sbt clean fastOptJS
	mv scala/target/scala-2.12/prime-to-js-fastopt.js $@

scheme/prime.js: scheme/prime.scm
	cat $(shell chicken-spock -library-path)/spock-runtime-min.js > $@
	chicken-spock -optimize $< >> $@
