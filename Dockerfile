# Purpose: Dockerfile to containerize the SWE645 HW1 web application using Nginx.
# Author: JoeYF

FROM nginx:alpine

COPY . /usr/share/nginx/html

RUN chmod -R 755 /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
