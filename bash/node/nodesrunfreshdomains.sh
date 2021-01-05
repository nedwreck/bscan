#!/bin/sh

# Get list of domains for this node to resolve

cd ~/ &&\

./newfresh.sh &&\

# Get resolvers.txt for massdns
sort -R ~/bscan/data/dnsresolver/bigresolvers2.txt | tail -n 200 > massdnsresolvers.txt &&\

# Running massdns on fresh domains
# Strip massdns output of record type and IP and feed that into dnsgen
# Feed dnsgen output directly into massdns again
./massdns/bin/massdns -r massdnsresolvers.txt -o S newfresh.txt \
| sed 's/\s.*$//'                                               \
| dnsgen -                                                      \
| ./massdns/bin/massdns 					\
-r massdnsresolvers.txt 					\
-w newfreshlivedomains.txt 					\
-o S  								&&\

# Sort massdns output
sort newfreshlivedomains.txt | uniq > newfreshlivedomains2.txt &&\

# Add this node's newfresh.txt to alreadyrundomains.txt
cat newfresh.txt >> ~/bscan/data/thepit/alreadyrundomains.txt &&\

# Add the massdnsoutput to freshlivedomains.txt
# Currently only looking for cname records to avoid wildcard domain crap
cat newfreshlivedomains2.txt | grep "CNAME" | cat > freshlivecname.txt &&\

cat freshlivecname.txt >> ~/bscan/data/thepit/freshlivedomains.txt
