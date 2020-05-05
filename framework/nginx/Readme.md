# Nginx 

## Install using Ansible

```ruby
ansible-playbook -i inventory.txt install.yml -u root
```

## Change the workers

File: /etc/nginx/nginx.conf

worker_processes  4;

## Check the WWW Home

File: /etc/nginx/conf.d/default.conf

```ruby
  location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
```


## SSL Certificate - for Docker Swarm Master

```
openssl req -x509 -days 3650 -nodes -newkey rsa:1024 -keyout cert.key -out cert.pem

Generating a 1024 bit RSA private key
.........++++++
.++++++
writing new private key to 'cert.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:IE
State or Province Name (full name) [Some-State]:Leinster
Locality Name (eg, city) []:Dublin
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Axway Dublin
Organizational Unit Name (eg, section) []:Champs
Common Name (e.g. server FQDN or YOUR name) []:master.swarm.private.cchamps.internal
Email Address []:support@axway.com

```

## Docker build

```
docker build -t cc-backend:v3 .
```

## Tag and Push

```
docker tag cc-backend:v3  548499473254.dkr.ecr.eu-west-1.amazonaws.com/v760-cc-backend:v3

docker push 548499473254.dkr.ecr.eu-west-1.amazonaws.com/v760-cc-backend:v3
The push refers to a repository [548499473254.dkr.ecr.eu-west-1.amazonaws.com/v760-cc-backend]
1d8af9a3ff50: Pushed 
34176cf76f3f: Pushed 
4c4a82684829: Layer already exists 
10ae4f8328f4: Layer already exists 
0b9d0deb5fd1: Layer already exists 
23211b646f16: Layer already exists 
268237643864: Layer already exists 
48be3b91dcb8: Layer already exists 
a4fc47c1db15: Layer already exists 
f85d5ff897c4: Layer already exists 
v3: digest: sha256:28d76d910053def1d41ff9662819c71f7e13e56374b323f18ef23a44c1b569e4 size: 2397
```




## Check Certificate

```
openssl s_client -connect master.swarm.private.cchamps.internal:8443  < /dev/null | openssl x509 -outform DER > derp.der
depth=0 C = IE, ST = Leinster, L = Dublin, O = Axway Dublin, OU = Champs, CN = master.swarm.private.cchamps.internal, emailAddress = support@axway.com
verify error:num=18:self signed certificate
verify return:1
depth=0 C = IE, ST = Leinster, L = Dublin, O = Axway Dublin, OU = Champs, CN = master.swarm.private.cchamps.internal, emailAddress = support@axway.com
verify return:1
DONE
```
