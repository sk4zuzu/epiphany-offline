SHELL := $(shell which bash)

DOMAIN ?= epiphany.lh
BITS   ?= 4096
DAYS   ?= 4096

define STDIN1
PL
.
.
.
.
.
.
endef

define STDIN2
PL
.
.
.
.
*.$(DOMAIN)
.
.
.
endef

define CSR_CNF
[req]
default_bits = $(BITS)
prompt = no
default_md = sha256
distinguished_name = dn
[dn]
C = PL
CN = *.$(DOMAIN)
endef

define V3_EXT
authorityKeyIdentifier = keyid, issuer
basicConstraints = CA:false
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth, clientAuth, codeSigning, emailProtection
subjectAltName = @alt_names
[alt_names]
DNS.1 = *.$(DOMAIN)
endef

export

.PHONY: all show clean

all: $(DOMAIN).chain.pem

show: $(DOMAIN).chain.pem
	openssl x509 -in $< -text -noout

clean:
	-rm -f *.pem *.cnf *.ext *.srl

$(DOMAIN).key.pem:
	openssl genrsa -out $(DOMAIN).key.pem $(BITS)

$(DOMAIN).cacert.pem: $(DOMAIN).key.pem
	openssl req -x509 -new -nodes -key $< -sha256 -days $(DAYS) -out $@ <<< "$$STDIN1"

$(DOMAIN).csr.cnf:
	tee $@ <<< "$$CSR_CNF"

$(DOMAIN).csr.pem: $(DOMAIN).key.pem $(DOMAIN).csr.cnf
	openssl req -new -key $(word 1,$^) -config $(word 2,$^) -out $@ <<< "$$STDIN2"

$(DOMAIN).v3.ext:
	tee $@ <<< "$$V3_EXT"

$(DOMAIN).cert.pem: $(DOMAIN).csr.pem $(DOMAIN).key.pem $(DOMAIN).cacert.pem $(DOMAIN).v3.ext
	openssl x509 -req -in $(word 1,$^) -CAkey $(word 2,$^) -CA $(word 3,$^) -CAcreateserial -days $(DAYS) -sha256 -extfile $(word 4,$^) -out $@

$(DOMAIN).chain.pem: $(DOMAIN).cert.pem $(DOMAIN).cacert.pem
	cat $^ > $@
