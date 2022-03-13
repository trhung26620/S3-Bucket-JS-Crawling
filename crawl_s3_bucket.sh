gau --subs $1 | grep '.js$' > vul1.txt
subfinder -d $1 -silent | httpx |subjs > vul3.txt
waybackurls $1 | grep '.js$' > vul2.txt
cat vul1.txt vul2.txt vul3.txt | sort -u > unique_sub.txt
cat unique_sub.txt | xargs -I% bash -c 'curl -sk "%" | grep "\.s3.amazonaws.com"' >> s3_bucket.txt
cat unique_sub.txt | xargs -I% bash -c 'curl -sk "%" | grep "\.s3.us-east-2.amazonaws.com"' >> s3_bucket.txt
cat unique_sub.txt | xargs -I% bash -c 'curl -sk "%" | grep "s3.amazonaws.com/*"' >> s3_bucket.txt
cat unique_sub.txt | xargs -I% bash -c 'curl -sk "%" | grep "s3.us-east-2.amazonaws.com/*"' >> s3_bucket.txt