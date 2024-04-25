#/bin/bash
USER="genesis0525" # 修正
APP_NAME="runpod-style-bert-vits2-api"
VERSION=$1

# VERSIONを目視で確認するのでy/Nで確認
echo $VERSION
echo "バージョンはこれでよろしいですか？"
read -p "y/N: " yn
case "$yn" in [yY]*) ;; *) echo "中止します" ; exit ;; esac

# git tag -a $VERSION -m "$VERSION"

# buildコマンド
sudo DOCKER_BUILDKIT=1 docker build --progress=plain . -f Dockerfile -t $USER/$APP_NAME:$VERSION

# pushコマンド
sudo docker push $USER/$APP_NAME:$VERSION