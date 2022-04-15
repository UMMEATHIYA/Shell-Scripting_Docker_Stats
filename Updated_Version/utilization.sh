#!/bin/sh

> timestamp.txt
> se_storage_service.txt
> inference.txt
> grafana.txt
> postprocessing.txt
> audio_detail.txt
> nifi.txt
> data.txt

#Giving headers
Header="timestamp inference_mem inference_cpu postprocessing_mem postprocessing_cpu grafana_mem grafana_cpu se_storage_service_mem se_storage_service_cpu\
 audio_detail_mem audio_detail_cpu nifi_mem nifi_cpu"
echo $Header >>data.txt

#capture time from memory logs
timestamp="$(cat test_case1.log| grep -A1 "Docker Stats"\
 | grep -B1 "UTC" |grep UTC | cut -d' ' -f4)"

#capture memory cpu from memory logs
inference="$(grep inference test_case1.log | cut -d'%' -f1,2 | sed 's/[a-z]//g' | sed 's/[A-Z]//g' |  sed 's/://g' | sed 's/_//g' | sed -e 's/^"//' -e 's/"$//' | sed "s/'[^']*'//g;s/->//g" | sed '/^[[:space:]]*$/d')"
postprocessing="$(grep postprocessing test_case1.log | cut -d'%' -f1,2 | sed 's/[a-z]//g' | sed 's/[A-Z]//g' |  sed 's/://g' | sed 's/_//g' | sed -e 's/^"//' -e 's/"$//' | sed "s/'[^']*'//g;s/->//g" | sed '/^[[:space:]]*$/d')"
grafana="$(grep grafana test_case1.log | cut -d'%' -f1,2 | sed 's/[a-z]//g' | sed 's/[A-Z]//g' |  sed 's/://g' | sed 's/_//g' | sed -e 's/^"//' -e 's/"$//' | sed "s/'[^']*'//g;s/->//g" | sed '/^[[:space:]]*$/d')"
se_storage_service="$(grep se_storage_service test_case1.log | cut -d'%' -f1,2 | sed 's/[a-z]//g' | sed 's/[A-Z]//g' |  sed 's/://g' | sed 's/_//g' | sed -e 's/^"//' -e 's/"$//' | sed "s/'[^']*'//g;s/->//g" | sed '/^[[:space:]]*$/d')"
audio_detail="$(grep audio_detail test_case1.log | cut -d'%' -f1,2 | sed 's/[a-z]//g' | sed 's/[A-Z]//g' |  sed 's/://g' | sed 's/_//g' | sed -e 's/^"//' -e 's/"$//' | sed "s/'[^']*'//g;s/->//g" | sed '/^[[:space:]]*$/d')"
nifi="$(grep nifi test_case1.log | cut -d'%' -f1,2 | sed 's/[a-z]//g' | sed 's/[A-Z]//g' |  sed 's/://g' | sed 's/_//g' | sed -e 's/^"//' -e 's/"$//' | sed "s/'[^']*'//g;s/->//g" | sed '/^[[:space:]]*$/d')"

#copying to respectice files
echo "$timestamp" >> timestamp.txt
echo "$se_storage_service" >> se_storage_service.txt
echo "$nifi" >>  nifi.txt
echo "$inference" >> inference.txt
echo "$audio_detail" >> audio_detail.txt
echo "$postprocessing" >> postprocessing.txt
echo "$grafana" >> grafana.txt


#combine the result
paste timestamp.txt se_storage_service.txt inference.txt grafana.txt postprocessing.txt audio_detail.txt nifi.txt>> data.txt




