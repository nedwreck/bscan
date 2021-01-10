#!/bin/sh

# Run this on the CDH at ~/bscan/data/thepit
cd ~/bscan/data/thepit &&\

# Sort and uniq freshdomains.txt file
touch freshdomains.txt &&\
mv -f freshdomains.txt freshdomains1.txt &&\
sort freshdomains1.txt | cat > freshdomains2.txt &&\
cat freshdomains2.txt | uniq >> freshdomains3.txt &&\
sort freshdomains3.txt | cat > freshdomains4.txt &&\
cat freshdomains4.txt | uniq > freshdomains5.txt &&\
cat freshdomains5.txt > freshdomains3.txt &&\

# Sort and uniq alreadyrundomains.txt
touch alreadyrundomains.txt &&\
mv -f alreadyrundomains.txt alreadyrundomains1.txt &&\
sort alreadyrundomains1.txt | cat > alreadyrundomains2.txt &&\
cat alreadyrundomains2.txt | uniq >> alreadyrundomains3.txt &&\
sort alreadyrundomains3.txt | cat > alreadyrundomains4.txt &&\
cat alreadyrundomains4.txt | uniq > alreadyrundomains5.txt &&\
cat alreadyrundomains5.txt > alreadyrundomains3.txt


####
# Run the list of fresh domains against the list of previously scanned domains
# to find unscanned domains

cat freshdomains5.txt > potentialdomains.txt &&\
cat alreadyrundomains5.txt >> potentialdomains.txt &&\
cat alreadyrundomains5.txt >> potentialdomains.txt &&\
sort potentialdomains.txt | cat > potentialdomains1.txt &&\
cat potentialdomains1.txt | uniq -u > newfreshdomains.txt &&\

####
# Get a list of potential domains ready to run through massdns

sort -R newfreshdomains.txt | cat > newfreshdomainsrand.txt &&\
cat newfreshdomainsrand.txt | tail -n 1000 > newfresh500.txt &&\

rm -f newfresha* &&\
split -n l/16 newfresh500.txt newfresh
