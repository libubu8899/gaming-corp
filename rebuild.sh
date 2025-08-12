#!/bin/bash
set -e

PROJECT_NAME="gaming-corp"
IMAGE_NAME="gaming-corp-web"
CONTAINER_NAME="gaming-corp-web"
PORT=8080
BUILD_DIR="dist"

echo "=== 1. 更新代码 ==="
git pull origin

echo "=== 2. 构建 Docker 镜像 ==="
docker build --build-arg BUILD_DIR=$BUILD_DIR -t $IMAGE_NAME .

echo "=== 3. 停止并删除旧容器（如存在） ==="
if [ "$(docker ps -aq -f name=^${CONTAINER_NAME}$)" ]; then
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

echo "=== 4. 启动新容器 ==="
docker run -d \
  --name $CONTAINER_NAME \
  -p $PORT:80 \
  --restart unless-stopped \
  $IMAGE_NAME

echo "=== 部署完成 ==="
docker ps -f name=$CONTAINER_NAME
