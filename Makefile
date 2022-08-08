clean:
	rm index.*
	rm serial.*
	rm *.crt
	rm *.key
	rm *.p12
	rm -rf client/*

serial.txt:
	echo 01 > serial.txt

index.txt:
	touch index.txt

ca-cert: serial.txt index.txt
	openssl req -x509 \
	  	-config openssl.cnf \
		-newkey rsa:4096 \
		-nodes \
		-keyout ca.key \
		-out ca.crt \
		-outform PEM \
		-subj '/C=IT/ST=RM/L=Rome/O=redhat.com/OU=Consulting/CN=test-ca/'
	
	openssl pkcs12 -export -in ca.crt -nokeys -out ca.p12 -password pass:123456 -caname ca.crt

all: clean ca-cert