#!/bin/sh

# This runs the list of cname domains through dig to look for nxdomain responses

cd ~/ &&\
./getdigdomains.sh &&\

touch nxdomain.txt &&\
rm -f nxdomain.txt &&\
for domain in $(cat digdomains.txt); do
	dig $domain | cat > digoutput.txt &&\
	if grep -q "status: NXDOMAIN" digoutput.txt; then
		echo "$domain" >> nxdomain.txt
	fi
done

sort nxdomain.txt | uniq >> ~/bscan/data/thepit/nxdomain.txt

