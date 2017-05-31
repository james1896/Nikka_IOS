//
//  algorithm.c
//  Bugatti
//
//  Created by toby on 07/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#include "algorithm.h"
#include <string.h>
#include <stdio.h>
#include<stdlib.h>
#include<time.h>

char* getSerialWithUid(int num){
    //得到当前秒数
    time_t t;
    time(&t);
    int t1 = t%1000/100;
    int t2 = t%100/10;
    int t3 = t%10;
    
    int i = t2%10;
    //
    
//    int result_i = num;
    static char buf[64]; // assumed large enough to cope with result
    
    //得到 每三位一组
    
    int timeNum = num/10;
    int first  = timeNum/1000/1000;
    int second = timeNum%1000000/1000;
    int third  = timeNum%1000;
    int  end    = num%10;
    //拆分成一位 一共九位
    
    int ram_2 = rand()%10;
    int ram_3 = rand()%10;
    int flog = rand()%9;
    
    //拆分成一位 一共九位
    int first_1 = first/100;
    int first_2 = first%100/10;
    int first_3 = first%10;
    
    int second_1 = second/100;
    int second_2 = second%100/10;
    int second_3 = second%10;
    
    int third_1 = third/100;
    int third_2 = third%100/10;
    int third_3 = third%10;
    
    //
    char firstBuf[6];
    char secondBuf[6];
    char thirdBuf[6];
//    char tmpBuf[6];
    
    //sort
    i = flog;
    if(i > 6){
        sprintf(firstBuf,"%d%d%d",first_3,first_1,first_2);
        sprintf(secondBuf,"%d%d%d",second_1,second_3,second_2);
        sprintf(thirdBuf,"%d%d%d",third_2,third_3,third_1);
    }
    else if(i==0){
        
        sprintf(firstBuf,"%d%d%d",third_2,third_3,second_1);
        sprintf(secondBuf,"%d%d%d",first_3,second_3,first_1);
        sprintf(thirdBuf,"%d%d%d",second_2,first_2,third_1);
        
    } else if (i == 1){
        sprintf(firstBuf,"%d%d%d",third_3,first_2,third_1);
        sprintf(secondBuf,"%d%d%d",second_1,second_2,second_3);
        sprintf(thirdBuf,"%d%d%d",first_3,third_2,first_1);
    } else if (i == 2){
        sprintf(firstBuf,"%d%d%d",first_1,third_3,second_2);
        sprintf(secondBuf,"%d%d%d",second_1,first_3,third_1);
        sprintf(thirdBuf,"%d%d%d",second_3,third_2,first_2);
    } else if (i == 3){
        sprintf(firstBuf,"%d%d%d",first_3,second_2,third_3);
        sprintf(secondBuf,"%d%d%d",second_1,first_1,third_1);
        sprintf(thirdBuf,"%d%d%d",second_3,third_2,first_2);
    } else if (i == 4){
        
        sprintf(firstBuf,"%d%d%d",third_2,second_2,third_3);
        sprintf(secondBuf,"%d%d%d",first_2,first_3,third_1);
        sprintf(thirdBuf,"%d%d%d",second_3,first_1,second_1);
    } else if (i == 5){
        sprintf(firstBuf,"%d%d%d",third_2,second_1,third_3);
        sprintf(secondBuf,"%d%d%d",first_2,second_3,first_3);
        sprintf(thirdBuf,"%d%d%d",second_2,first_1,third_1);
    } else if (i == 6){
        sprintf(firstBuf,"%d%d%d",second_3,second_1,third_3);
        sprintf(secondBuf,"%d%d%d",first_2,third_2,first_3);
        sprintf(thirdBuf,"%d%d%d",second_2,first_1,third_1);
    }
    
    sprintf(buf,"13%s%1d%1d%s%d%d%s%d%1d%1d",
            firstBuf,
            end,
            ram_2,
            secondBuf,
            t2,
            t3,
            thirdBuf,
            t1,
            flog,
            ram_3);
    
//    return (*env)->NewStringUTF(env, buf);
    
//    static char s[100];
//    strcpy(s, "abc ");
    return buf;
}



//得到当前秒数
//time_t t;
//time(&t);
//int t1 = t%1000/100;
//int t2 = t%100/10;
//int t3 = t%10;
//
//int i = t2%10;
////
//jint result_i = num;
//char buf[64]; // assumed large enough to cope with result
//
////得到 每三位一组
//jint first  = num/1000/1000;
//jint second = num%1000000/1000;
//jint third  = num%1000;
//
////拆分成一位 一共九位
//int ram_1 = rand()%10;
//int ram_2 = rand()%10;
//int ram_3 = rand()%10;
//int flog = rand()%9;
//
////拆分成一位 一共九位
//int first_1 = first/100;
//int first_2 = first%100/10;
//int first_3 = first%10;
//
//int second_1 = second/100;
//int second_2 = second%100/10;
//int second_3 = second%10;
//
//int third_1 = third/100;
//int third_2 = third%100/10;
//int third_3 = third%10;
//
////
//char firstBuf[6];
//char secondBuf[6];
//char thirdBuf[6];
//char tmpBuf[6];
//
////sort
//i = t2;
//if(i > 6){
//    sprintf(firstBuf,"%d%d%d",first_3,first_1,first_2);
//    sprintf(secondBuf,"%d%d%d",second_1,second_3,second_2);
//    sprintf(thirdBuf,"%d%d%d",third_2,third_3,third_1);
//}
//else if(i==0){
//    
//    sprintf(firstBuf,"%d%d%d",third_2,third_3,second_1);
//    sprintf(secondBuf,"%d%d%d",first_3,second_3,first_1);
//    sprintf(thirdBuf,"%d%d%d",second_2,first_2,third_1);
//    
//} else if (i == 1){
//    sprintf(firstBuf,"%d%d%d",third_3,first_2,third_1);
//    sprintf(secondBuf,"%d%d%d",second_1,second_2,second_3);
//    sprintf(thirdBuf,"%d%d%d",first_3,third_2,first_1);
//} else if (i == 2){
//    sprintf(firstBuf,"%d%d%d",first_1,third_3,second_2);
//    sprintf(secondBuf,"%d%d%d",second_1,first_3,third_1);
//    sprintf(thirdBuf,"%d%d%d",second_3,third_2,first_2);
//} else if (i == 3){
//    sprintf(firstBuf,"%d%d%d",first_3,second_2,third_3);
//    sprintf(secondBuf,"%d%d%d",second_1,first_1,third_1);
//    sprintf(thirdBuf,"%d%d%d",second_3,third_2,first_2);
//} else if (i == 4){
//    
//    sprintf(firstBuf,"%d%d%d",third_2,second_2,third_3);
//    sprintf(secondBuf,"%d%d%d",first_2,first_3,third_1);
//    sprintf(thirdBuf,"%d%d%d",second_3,first_1,second_1);
//} else if (i == 5){
//    sprintf(firstBuf,"%d%d%d",third_2,second_1,third_3);
//    sprintf(secondBuf,"%d%d%d",first_2,second_3,first_3);
//    sprintf(thirdBuf,"%d%d%d",second_2,first_1,third_1);
//} else if (i == 6){
//    sprintf(firstBuf,"%d%d%d",second_3,second_1,third_3);
//    sprintf(secondBuf,"%d%d%d",first_2,third_2,first_3);
//    sprintf(thirdBuf,"%d%d%d",second_2,first_1,third_1);
//}
//
//
//
////    sprintf(buf,"%d%d%d%d%d%d%d%d%d",i1,j1,k1,i2,j2,k2,i3,j3,k3);
//sprintf(buf,"13%s%1d%1d%s%d%d%s%d%1d%1d",
//        firstBuf,
//        ram_1,
//        ram_2,
//        secondBuf,
//        t2,
//        t3,
//        thirdBuf,
//        t1,
//        flog,
//        ram_3);
//
//return (*env)->NewStringUTF(env, buf);
