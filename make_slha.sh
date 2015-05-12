#!/bin/bash

main()
{
  if [ ! -z "$1" ] && [ -e $1 ]
  then

    source $1

  else

    echo Please provide a configuration file.
    exit

  fi

  ###################### No modifications below this line are necessary ###########################

  TOTAL=`cat $SLHAFILENAME | wc -l`

  cd ${MAINDIR}

  for (( i = 1; i <= $TOTAL; i = i+1 ))
  do

    j=`cat $SLHAFILENAME | awk -v number=$i '{if (number == NR) print $1}'`
    k=`cat $SLHAFILENAME | awk -v number=$i '{if (number == NR) print $2}'`
    l=`cat $SLHAFILENAME | awk -v number=$i '{if (number == NR) print $3}'`
    m=`echo "${k}-5" | bc`
    n=`echo "${k}+5" | bc`

    echo "test/SusyHiggs_template2.slha 0 ${m} ${n} ${k} ${j} 5000 5000 store_${l}/slha/${TAG}_${NAMEONE}${j}_${NAMETWO}${k}.slha"
    runSLHA test/SusyHiggs_template2.slha 0 ${m} ${n} ${k} ${j} 5000 5000 store_${l}/slha/${TAG}_${NAMEONE}${j}_${NAMETWO}${k}.slha

  done
}

runSLHA()
{
  if [ $# -ne 9 ]; then
           echo Usage: $0 \<inputname\> \<mbino\> \<mhiggsino1\> \<mhiggsino2\> \<mchargino1\> \<mstop1\> \<mstop2\> \<mdecouple\> \<outputname\>
           exit 127
  fi

  cp $1 $1_temp_1

  ( cat $1_temp_1 | awk '{

         if ($2 == "mgluino") printf "%10s%19.8e%4s %s\n","1000021",'$8',$3,$4;
         else if ($2 == "msquarkdL") printf "%10s%19.8e%4s %s\n","1000001",'$8',$3,$4;
         else if ($2 == "msquarkuL") printf "%10s%19.8e%4s %s\n","1000002",'$8',$3,$4;
         else if ($2 == "msquarksL") printf "%10s%19.8e%4s %s\n","1000003",'$8',$3,$4;
         else if ($2 == "msquarkcL") printf "%10s%19.8e%4s %s\n","1000004",'$8',$3,$4;
         else if ($2 == "msquarkbL") printf "%10s%19.8e%4s %s\n","1000005",'$8',$3,$4;
         else if ($2 == "msquarkt1") printf "%10s%19.8e%4s %s\n","1000006",'$6',$3,$4;
         else if ($2 == "msquarkdR") printf "%10s%19.8e%4s %s\n","2000001",'$8',$3,$4;
         else if ($2 == "msquarkuR") printf "%10s%19.8e%4s %s\n","2000002",'$8',$3,$4;
         else if ($2 == "msquarksR") printf "%10s%19.8e%4s %s\n","2000003",'$8',$3,$4;
         else if ($2 == "msquarkcR") printf "%10s%19.8e%4s %s\n","2000004",'$8',$3,$4;
         else if ($2 == "msquarkbR") printf "%10s%19.8e%4s %s\n","2000005",'$8',$3,$4;
         else if ($2 == "msquarkt2") printf "%10s%19.8e%4s %s\n","2000006",'$7',$3,$4;
         else if ($2 == "mbino") printf "%10s%19.8e%4s %s\n","1000022",'$2',$3,$4;
         else if ($2 == "mhiggs2") printf "%10s%19.8e%4s %s\n","35",'$8',$3,$4;
         else if ($2 == "mhiggs3") printf "%10s%19.8e%4s %s\n","36",'$8',$3,$4;
         else if ($2 == "mhiggs4") printf "%10s%19.8e%4s %s\n","37",'$8',$3,$4;
         else if ($2 == "mneut2") printf "%10s%19.8e%4s %s\n","1000023",'$3',$3,$4;
         else if ($2 == "mneut3") printf "%10s%19.8e%4s %s\n","1000025",'$4',$3,$4;
         else if ($2 == "mneut4") printf "%10s%19.8e%4s %s\n","1000035",'$8',$3,$4;
         else if ($2 == "mchar1") printf "%10s%19.8e%4s %s\n","1000024",'$5',$3,$4;
         else if ($2 == "mchar2") printf "%10s%19.8e%4s %s\n","1000037",'$8',$3,$4;
         else if ($2 == "mselL") printf "%10s%19.8e%4s %s\n","1000011",'$8',$3,$4;
         else if ($2 == "msnue") printf "%10s%19.8e%4s %s\n","1000012",'$8',$3,$4;
         else if ($2 == "msmuL") printf "%10s%19.8e%4s %s\n","1000013",'$8',$3,$4;
         else if ($2 == "msnumu") printf "%10s%19.8e%4s %s\n","1000014",'$8',$3,$4;
         else if ($2 == "mstauL") printf "%10s%19.8e%4s %s\n","1000015",'$8',$3,$4;
         else if ($2 == "msnutau") printf "%10s%19.8e%4s %s\n","1000016",'$8',$3,$4;
         else if ($2 == "mselR") printf "%10s%19.8e%4s %s\n","2000011",'$8',$3,$4;
         else if ($2 == "msmuR") printf "%10s%19.8e%4s %s\n","2000013",'$8',$3,$4;
         else if ($2 == "mstauR") printf "%10s%19.8e%4s %s\n","2000015",'$8',$3,$4;
         else print;
  }' ) > $9

  rm -f $1_temp_*
}

main ${1}
