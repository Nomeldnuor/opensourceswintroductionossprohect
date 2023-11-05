#! /bin/bash

echo "--------------------------"
#echo "User Name: $(whoami)"
echo "User Name: 조성찬"
echo "Student Number: 12223821"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific"
echo "'movie id' from 'u.item'"
echo "2. Get the data of action genre movies from 'u.item'"
echo "3. Get the average 'rating' of the movie identified by"
echo "specific 'movie id' from 'u.data'"
echo "4. Delete the 'IMDb URL' from 'u.item"
echo "5. Get the data about users from 'u.user'"
echo "6. Modify the format of 'release date' in 'u.item'"
echo "7. Get the data of movies rated by a specific 'user id'"
echo "from 'u.data'"
#echo "8. Get the average 'rating' of movies rated by users with"
#echo "'age' between 20 and 29 and 'occupation' as 'programmer'"
echo "9. Exit"
echo "--------------------------"
endr=0;
while [ $endr == 0 ]
do
read -p "Enter your choice [ 1-9 ] " choi
case $choi in
1)
read -p "Please enter the 'movie id' (1~1682):" mvid1
cat $1 | awk -F '|' -v mvid1="$mvid1" '$1 == mvid1' "$1"
;;
2)
read -p "Do you want to get the data of 'action' genre movies from 'u.item'?(y/n):" ans2
if [ $ans2 = "y" ]
then
    cat $1 | awk -F '|' '$7==1 {print $1, $2; cnt++; if(cnt>=10) exit}'
fi
;;
3)
read -p "Please enter the 'movie id' (1~1682):" mvid
cat $2 | awk -v mvid="$mvid" '$2 == mvid{cnt3++; ttl+=$3} END {printf("average rating of %d : %.5f\n",mvid,ttl/cnt3) }'
;;
4)
read -p "Do you want to delete the 'IMDbURL'from 'u.item'?(y/n):" ans
if [ $ans = "y" ]
then
    cat $1 | awk -F '|' '{ a=1; while ( a < NF ) { if(a!=5) printf("%s",$a); if(a<23) printf("|"); a++; };printf("\n"); cnt++; if(cnt>=10) exit}'
fi
;;
5)
read -p "Do you want to get the data about users from 'u.user'?(y/n):" ans
if [ $ans = "y" ]
then
    cat $3 | awk -F '|' '{ printf("user %s is %s years old %s %s\n", $1, $2, ($3=="M"?"male":"female"), $4); cnt++; if(cnt>=10) exit}'
fi
;;
6)
read -p "Do you want to Modify the format of 'release data' in 'u.item'?(y/n):" ans
if [ $ans = "y" ]
then
    tail -10 $1 | sed -E 's/([0-9]{2})-([A-Za-z]{3})-([0-9]{4})/\3\2\1/' | sed -E 's/Jan/01/' | sed -E 's/Feb/02/' | sed -E 's/Mar/03/' | sed -E 's/Apr/04/' | sed -E 's/May/05/' | sed -E 's/Jun/06/' | sed -E 's/Jul/07/' | sed -E 's/Aug/08/' | sed -E 's/Seb/09/' | sed -E 's/Oct/10/' | sed -E 's/Nov/11/' | sed -E 's/Dec/12/'
fi
;;
7)
read -p "Please enter the 'user id' (1~943):" uid
#sort <0 $2 | awk -v uid="$uid" -v NR="$NR" -v NF="$NF" '$1==uid {if($NF==1) printf("%d",$2); else printf("|%d", $2) ;}' 
cat $2 | awk -v uid="$uid" -v NR="$NR" -v NF="$NF" '$1==uid {print $2;}' | sort -k1n | tr '\n' '|' | sed 's/.$//'
var3=$(cat $2 | awk -v uid="$uid" -v NR="$NR" -v NF="$NF" '$1==uid {print $2;}' | sort -k1n | tr '\n' '|' | sed 's/.$//')
echo ""
echo $var3
rep=0
while false
do
((rep++))


cat $2 | awk -v uid="$uid" -v NR="$NR" -v NF="$NF" '$1==uid {print $2;}' | awk -F '|' -v mvid1="$mvid1" -v iteml="$1" '$1 == mvid1{ system("sed -n '$1'p iteml") }'


#cat $2 | awk -v uid="$uid" -v NR="$NR" -v NF="$NF" '$1==uid {print $2; cnt++ ; if(cnt>=10) exit}' | sort -k1n | tr '\n' '|' | sed 's/.$//'

#cat $2 | awk -v uid="$uid" -v NR="$NR" -v NF="$NF" '
#    $1==uid {print $2; cat u.item; | 
#    awk -F "|" "$1==3{print $2}" cnt++; if( cnt >= 10 ) exit}' 
#    | sort -k1n | tr '\n' '|' | sed 's/.$//'

#cat $2 | awk -v uid="$uid" 'NR<=10 && $1==uid {print $2; system("cat u.item | sed -n "$2"p '$1'");printf("\n"); cnt++; if(cnt>=10) exit}'  | sort -k1n | tr '\n' '|' | sed 's/.$//'

#cat u.item | awk -F '|' '$1==3{print $2}'
done
;;
#8)
#asdadsa=10;
#cat $1 | awk -F '|' -v afa="$asdadsa" '1==1{print afa; afa++;}'
#echo $asdadsa
#;;
9)
echo Bye!
endr=1;

;;
esac



done


