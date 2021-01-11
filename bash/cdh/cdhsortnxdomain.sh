#!/bin/sh

# This will sort the list of nxdomain'd cnames
# and find their corresponding subdomains
# and split that list into equal parts

cd ~/bscan/data/thepit &&\

mv -f nxdomain.txt nxdomain1.txt &&\
sort nxdomain1.txt | cat > nxdomain2.txt &&\
cat nxdomain2.txt | uniq > nxdomiain3.txt &&\
cat nxdomain3.txt >> nxdomain_all.txt &&\

sort nxdomain_all.txt | cat > nxdomain_all1.txt &&\
cat nxdomain_all1.txt | uniq > nxdomain_all2.txt &&\

touch cnamesub1.txt &&\
rm -f cnamesub1.txt &&\
touch nxdomain3.txt &&\
for domain in $(cat nxdomain3.txt); do
        cat cnamerecords5.txt | grep $domain | cat > cnamesub.txt &&\
        cat cnamesub.txt | sed 's/\s.*$//' >> cnamesub1.txt
done

rm -f curldomainsa* &&\
touch cnamesub1.txt &&\
split -n l/16 cnamesub1.txt curldomains
