VERSION=0.2.0
JARFILE=datomic-client-memdb.$(VERSION).jar

$(JARFILE):
	clojure \
	  -Sdeps '{:deps \
	           {pack/pack.alpha \
	            {:git/url "https://github.com/juxt/pack.alpha.git" \
	             :sha "8acf80dd4d6e5173585f5c6fec7af28a310f3ed7"}}}' \
	  -m mach.pack.alpha.skinny \
	  --no-libs \
	  --project-path $@

pom.xml:
	clojure -Spom

publish: $(JARFILE) pom.xml
	mvn deploy:deploy-file -Dfile=$(JARFILE) -DrepositoryId=clojars -Durl=https://clojars.org/repo -DpomFile=pom.xml
