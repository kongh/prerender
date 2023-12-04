FROM node:latest

LABEL Description="Prerender is a node server that uses Headless Chrome to render HTML, screenshots, PDFs, and HAR files out of any web page."

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
  && apt-get update \
  && apt-get install -y google-chrome-stable \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY package.json .
COPY package-lock.json .
RUN npm install
RUN npm install -g pm2
COPY . .

EXPOSE 8080

CMD ["pm2-runtime", "server.js"]