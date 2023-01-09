#!/bin/bash
var=1.0
if [ $1 ];then
var=$1
fi

docker build -t my_img:1.0 .

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/c7o8u9c1

docker tag my_img:${var} public.ecr.aws/c7o8u9c1/shoval_ecr:${var}

docker push public.ecr.aws/c7o8u9c1/shoval_ecr:${var}

tar -czvf start_to_ec2.tar.gz docker-compose.yaml start_app.sh ./src/main/webapp ./nginx1


echo "yes" | scp start_to_ec2.tar.gz ubuntu@13.37.227.82:/home/ubuntu/

ssh ubuntu@13.37.227.82 "export ${var}  && bash ec2_script.sh"


# echo "yes" | scp start_to_ec2.tar.gz ubuntu@13.38.99.105:/home/ubuntu/

# ssh ubuntu@13.38.99.105 "export ${var} && bash ec2_script.sh"