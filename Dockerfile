FROM node:latest 

ADD ./package.json package.json
RUN npm install -g bower
RUN npm install

ADD ./bower.json bower.json
RUN bower install --allow-root

EXPOSE 7000 7000

# ADD ./node_modules node_modules
ADD ./lib lib
ADD ./views views
ADD ./app.js app.js
ADD ./config.js config.js
ADD ./idp-public-cert.pem idp-public-cert.pem
ADD ./idp-private-key.pem idp-private-key.pem
ADD ./public public

ENTRYPOINT [ "node",  "app.js", "--acs", "https://deptva-vetsgov-eval.okta.com/sso/saml2/0oa1pbnlkmlWpo0q22p7", "--issuer", "samlproxy-idp.vetsgov.dev", "--aud", "https://www.okta.com/saml2/service-provider/spshbtcxwhreqinrtome", "--ibu", "https://dev.vets.gov/samlproxy/idp" ]
