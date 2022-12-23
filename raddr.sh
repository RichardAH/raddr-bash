#!/bin/bash                                                                                                            
                                                                                                                       
if [ -z "$1" ]                                                                                                         
then                                                                                                                   
    echo "Please provide an r-address as an argument."                                                                 
    exit 1                                                                                                             
fi                                                                                                                     
                                                                                                                       
alphabet="rpshnaf39wBUDNEGHJKLM4PQRST7VWXYZ2bcdeCg65jkm8oFqi1tuvAxyz"                                                  
                                                                                                                       
base58_num=$1                                                                                                          
base16_num=""                                                                                                          
sum="0"                                                                                                                
for((i=0; i < ${#base58_num}; i++))                                                                                    
do                                                                                                                     
    digit=${base58_num:i:1}                                                                                            
    index=$(echo $alphabet | grep -bo $digit | cut -d: -f1)                                                            
    p=$(echo "$index * (58^(${#base58_num}-1-$i))" | bc)                                                               
    sum=$(echo "$sum + $p" | bc)                                                                                       
done                                                                                                                   
base16_num=$(echo "ibase=10;obase=16;$sum" | bc )                                                                      
echo "r-Address: $base58_num"                                                                                          
echo "HEX w/chksum: $base16_num"                                                                                       
echo "HEX w/o chks: ${base16_num:0:-8}"  
