ssh jasmeetsingh@hadoop.rcc.uchicago.edu
hadoop fs -ls /user/kadochnikov/bdp_class_2/
hadoop fs -ls /user/kadochnikov/bdp_class_2/cities
hadoop fs -mkdir /user/jasmeetsingh/bdpClass2
hadoop fs -cp /user/kadochnikov/bdp_class_2/cities/* /user/jasmeetsingh/bdpClass2
hadoop fs -ls /user/jasmeetsingh/bdpClass2
mkdir /home/jasmeetsingh/bdpClass2/
hadoop fs -get /user/jasmeetsingh/bdpClass2/* /home/jasmeetsingh/bdpClass2/
cd bdpClass2/
ls -l 