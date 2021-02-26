#!/bin/bash
docker build -t mjsouthcott/safety-zone .
docker push mjsouthcott/safety-zone

ssh deploy@$DEPLOY_SERVER << EOF
docker pull mjsouthcott/safety-zone
docker stop api-saftey-zone || true
docker rm api-saftey-zone || true
docker rmi mjsouthcott/safety-zone:current || true
docker tag mjsouthcott/safety-zone:latest mjsouthcott/safety-zone:current
docker run -d --restart always --name api-saftey-zone -p 3000:3000 mjsouthcott/safety-zone:current
EOF
