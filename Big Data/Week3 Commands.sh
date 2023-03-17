############################# SSH BEG #############################

ssh jasmeetsingh@hadoop.rcc.uchicago.edu
find /project2/msca/kadochnikov/data/ -name Municipal_Court_Caseload_Information.zip
mkdir /home/jasmeetsingh/bdp_Assignment3/
cp /project2/msca/kadochnikov/data/Municipal_Court_Caseload_Information.zip /home/jasmeetsingh/bdp_Assignment3/
cd /home/jasmeetsingh/bdp_Assignment3
unzip Municipal_Court_Caseload_Information.zip
ls -l
head Municipal_Court_Caseload_Information.csv

############################# SSH END #############################

############################# HIVE BEG #############################

hive
!clear;
use jasmeetsingh;
show tables;
CREATE TABLE CourtCases(OffenseCaseType STRING, OffenseDate STRING, OffenseTime STRING, OffenseChargeDescription STRING, OffenseStreetName STRING, OffenseCrossStreetCheck STRING, OffenseCrossStreet STRING, SchoolZone STRING, ConstructionZone STRING, CaseClosed STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' STORED AS TEXTFILE tblproperties ("skip.header.line.count"="1");
LOAD DATA LOCAL INPATH '/home/jasmeetsingh/bdp_Assignment3/Municipal_Court_Caseload_Information.csv' INTO TABLE courtcases;
describe formatted courtcases;
SELECT * FROM courtcases limit 10;
SELECT OffenseCaseType, count(*) as CountOfCases from courtcases group by OffenseCaseType ORDER BY CountOfCases DESC;
SELECT OffenseChargeDescription, count(*) as CountOfOffense from courtcases group by OffenseChargeDescription ORDER BY CountOfOffense DESC, OffenseChargeDescription DESC LIMIT 1;

############################# HIVE END #############################

############################# CLEAN UP #############################
cd /home/jasmeetsingh/bdp_Assignment3
rm -rf bdp_Assignment3