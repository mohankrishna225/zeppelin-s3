#!/bin/bash

# Your repo name
repo=mohankrishna225
# Zeppelin version
version=0.10.0
# Spark version compatible to the Zeppelin version
spark_version=3.3.2
# Hadoop major version
hadoop_version=3
# Hadoop minor version
hadoop_minor_version=0
# AWS SDK version compatible to the Hadoop version
aws_sdk_version=1.11.271

cd zeppelin-distribution-binary
docker build --build-arg version=$version -t ${repo}/zeppelin-distribution:${version} .

docker push ${repo}/zeppelin-distribution:${version}

cd ..
cd zeppelin-server
docker build --build-arg version=$version --build-arg REPO=$repo -t ${repo}/zeppelin-server:${version} .

docker push ${repo}/zeppelin-server:${version}
cd ..
cd zeppelin-interpreter
docker build --build-arg version=$version --build-arg REPO=$repo -t ${repo}/zeppelin-interpreter:${version} .

#docker save -o zeppelin-interpreter:${version}.tar ${repo}/zeppelin-interpreter:${version}


docker push ${repo}/zeppelin-interpreter:${version}
cd ..
cd spark
docker build --build-arg version=$version --build-arg SPARK_VERSION=$spark_version \
 --build-arg HADOOP_VERSION=$hadoop_version --build-arg HADOOP_VERSION_MINOR=$hadoop_minor_version \
 --build-arg AWS_SDK_VERSION=$aws_sdk_version --build-arg REPO=$repo \
 -t ${repo}/spark:${version} .

#docker save -o spark.tar ${repo}/spark:${version}

docker push ${repo}/spark:${version}

