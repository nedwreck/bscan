#!/bin/sh

# This will sort the list of nxdomain'd cnames
# and find their corresponding subdomains
# and split that list into equal parts

cd ~/bscan/data/thepit &&\

sort nxdomain.txt | cat > nxdomain1.txt &&\
cat nxdomain1.txt | uniq > nxdomiain2.txt &&\

rm -f cnamesub1.txt &&\
for domain in $(cat nxdomain2.txt); do
        cat cnamerecords5.txt | grep $domain | cat > cnamesub.txt &&\
        cat cnamesub.txt | sed 's/\s.*$//' >> cnamesub1.txt
done

rm -f curldomainsa* &&\
split -n l/16 cnamesub1.txt curldomains
