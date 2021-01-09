#!/bin/sh

# This sends cname subdomains through curl to
# look for 404 replies

cd ~/ &&\

touch cnamesub404.txt &&\
rm cnamesub404.txt &&\
for domain in $(cat curldomains.txt); do
	curl -s --head --connect-timeout 9 --request GET $domain > cnamesubcurl.txt &&\
	if grep -q "404" cnamesubcurl.txt; then
		echo $domain >> cnamesub404.txt
	fi
done

# Get resolvers.txt for massdns
sort -R ~/bscan/data/dnsresolver/bigresolvers2.txt | tail -n 200 > massdnsresolvers.txt &&\

# Running massdns on cname subdomains with 404 response
./massdns/bin/massdns -r massdnsresolvers.txt -w sub404records.txt -o S cnamesub404.txt &&\

sort sub404records.txt | uniq >> ~/bscan/data/thepit/sub404.txt
