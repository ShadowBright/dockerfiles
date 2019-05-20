spark-submit --class org.apache.spark.examples.SparkPi --master yarn --deploy-mode cluster /opt/spark/examples/jars/spark-examples_*.jar 100 > test.out 2>&1 &

tail -f test.out

cat /opt/hadoop/logs/userlogs/*/*/stdout
