#!/bin/sh

cd ~/bscan/data/thepit &&\

# Sort out the freshlivedomains.txt file
touch freshlivedomains.txt &&\
mv -f freshlivedomains.txt freshlivedomains1.txt &&
sort freshlivedomains1.txt | cat > freshlivedomains2.txt &&\
cat freshlivedomains2.txt | uniq >> freshlivedomains3.txt &&\
sort freshlivedomains3.txt | cat > freshlivedomains4.txt &&\
cat freshlivedomains4.txt | uniq > freshlivedomains5.txt &&\

touch blacklisted.txt &&\
rm -f blacklisted.txt &&\
for wildcarddomain in $(cat wildcardblacklist.text); do
        cat freshlivedomains5.txt | grep $wildcarddomain >> blacklisted.txt
done

cat freshlivedomains5.txt > wildcardblacklistcheck.txt &&\
cat blacklisted.txt >> wildcardblacklistcheck.txt &&\
sort wildcardblacklistcheck.txt | cat > wildcardblacklistcheck1.txt &&\
cat wildcardblacklistcheck1.txt | uniq -u > freshlivedomains5.txt &&\

cat freshlivedomains5.txt > freshlivedomains3.txt &&\

# Grep the cname records out of freshlivedomains5.txt
cat freshlivedomains5.txt | grep "CNAME" | cat >> cnamerecords.txt &&\
mv -f cnamerecords.txt cnamerecords1.txt &&\
sort cnamerecords1.txt | cat > cnamerecords2.txt &&\
cat cnamerecords2.txt | uniq >> cnamerecords3.txt &&\
sort cnamerecords3.txt | cat > cnamerecords4.txt &&\
cat cnamerecords4.txt | uniq > cnamerecords5.txt &&\

touch blacklisted.txt &&\
rm -f blacklisted.txt &&\
for wildcarddomain in $(cat wildcardblacklist.text); do
        cat cnamerecords5.txt | grep $wildcarddomain >> blacklisted.txt
done

cat cnamerecords5.txt > wildcardblacklistcheck.txt &&\
cat blacklisted.txt >> wildcardblacklistcheck.txt &&\
sort wildcardblacklistcheck.txt | cat > wildcardblacklistcheck1.txt &&\
cat wildcardblacklistcheck1.txt | uniq -u > cnamerecords5.txt &&\

cat cnamerecords5.txt > cnamerecords3.txt &&\

##########
## Need to get dig and curl set up to work on the nodes
## instead of the CDH

# Get a list of only the canonical domains
rm cnamedomains.txt &&\
cat cnamerecords5.txt | sed 's/.* //' >> cnamedomains.txt &&\
sort cnamedomains.txt | cat > cnamedomains1.txt &&\
cat cnamedomains1.txt | uniq > cnamedomains2.txt &&\
split -n l/16 cnamedomains2.txt digdomains &&\




#rm -f cnamesub1.txt &&\
#for domain in $(cat nxdomain_current.txt); do
#        cat cnamerecords5.txt | grep $domain | cat > cnamesub.txt &&\
#        cat cnamesub.txt | sed 's/\s.*$//' >> cnamesub1.txt
#done
#
#touch cnamesub404.txt &&\
#rm cnamesub404.txt &&\
#for domain in $(cat cnamesub1.txt); do
#curl -s --head --connect-timeout 9 --request GET $domain > cnamesubcurl.txt &&\
#        if grep -q "404" cnamesubcurl.txt; then
#                echo $domain >> cnamesub404.txt
#        fi
#done
#
#touch cnamesub404.txt &&\
#sort cnamesub404.txt | cat > cnamesub4041.txt &&\
#cat cnamesub4041.txt | uniq > cnamesub404_current.txt
