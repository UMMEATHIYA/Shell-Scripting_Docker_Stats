#!/bin/sh



#Giving headers
Header="timestamp couchdbthree_mem couchdbthree_cpu couchdbtwo_mem couchdbtwo_cpu couchdbone_mem couchdbone_cpu storage_load_mem storage_load_cpu load_couch_mem load_couch_cpu load-preprocessing_mem load-preprocessing_cpu load-rule_mem load-rule_cpu logger_service_mem logger_service_cpu ruleengine_service_mem ruleengine_service_cpu storage_service_ecr_storage_mem storage_service_ecr_storage_cpu pre_processing_ecr1_mem pre_processing_ecr1_cpu  "
echo $Header >> data_docker.txt

#capture time from memory logs
cat memory_72.log| grep -A1 "Docker Stats" | grep -B1 "UTC" |grep UTC | cut -d' ' -f4 >> timestamp.txt

#capture memory cpu from memory logs
grep load_couch memory_72.log | cut -d'%' -f1,2  >> load_couch.txt
grep couchdbthree memory_72.log | cut -d'%' -f1,2  >> couchdbthree.txt
grep couchdbtwo memory_72.log | cut -d'%' -f1,2 >> couchdbtwo.txt
grep couchdbone memory_72.log | cut -d'%' -f1,2 >> couchdbone.txt
grep storage_load memory_72.log | cut -d'%' -f1,2  >> storage_load.txt
grep load-preprocessing memory_72.log | cut -d'%' -f1,2  >> load-preprocessing.txt
grep load-rule memory_72.log | cut -d'%' -f1,2  >> load-rule.txt
grep ruleengine_service memory_72.log | cut -d'%' -f1,2 >> ruleengine_service.txt
grep logger_service memory_72.log | cut -d'%' -f1,2 >> logger_service.txt
grep pre_processing_ecr1 memory_72.log | cut -d'%' -f1,2 >> pre_processing_ecr1.txt
grep storage_service_ecr_storage memory_72.log | cut -d'%' -f1,2 >> storage_service_ecr_storage.txt


#combine the result
paste timestamp.txt couchdbthree.txt couchdbtwo.txt couchdbone.txt storage_load.txt load_couch.txt load-preprocessing.txt load-rule.txt logger_service.txt ruleengine_service.txt storage_service_ecr_storage.txt pre_processing_ecr1.txt  >> data_docker.txt




