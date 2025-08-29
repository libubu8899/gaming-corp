# syntax=docker/dockerfile:1
FROM nginx:1.27-alpine

WORKDIR /usr/share/nginx/html

# 把整个项目文件拷进去（排除 node_modules、.git 等）
COPY . .

# 自定义 nginx 配置（支持 SPA 回退、静态资源缓存）
RUN rm -f /etc/nginx/conf.d/default.conf && \
    printf '%s\n' \
    'server { listen 80; server_name _; root /usr/share/nginx/html; index index.html;' \
    'location / { try_files $uri $uri/ /index.html; }' \
    'location ~* \.css$ { expires -1; add_header Cache-Control "no-cache, must-revalidate"; }' \
    'location ~* \.(js|png|jpg|jpeg|gif|svg|ico|woff2?)$ { expires 7d; add_header Cache-Control "public"; access_log off; }' \
    '}' > /etc/nginx/conf.d/site.conf

COPY ./google26b306e5e0c8e276.html /usr/share/nginx/html/google26b306e5e0c8e276.html

EXPOSE 80
