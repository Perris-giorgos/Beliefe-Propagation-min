/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/peraxor/MEGAsync/27-7/VHDL/belief_propagation/comparator_min_only.vhd";
extern char *IEEE_P_1242562249;

unsigned char ieee_p_1242562249_sub_3044623114557194624_1035706684(char *, char *, char *, char *, char *);
char *ieee_p_1242562249_sub_4437083849341520093_1035706684(char *, char *, char *, char *);


static void work_a_2260338868_1697392497_p_0(char *t0)
{
    char t1[16];
    char t5[16];
    char t10[16];
    char *t2;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    unsigned char t9;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(25, ng0);
    t2 = (t0 + 1032U);
    t3 = *((char **)t2);
    t2 = (t0 + 5440U);
    t4 = ieee_p_1242562249_sub_4437083849341520093_1035706684(IEEE_P_1242562249, t1, t3, t2);
    t6 = (t0 + 1192U);
    t7 = *((char **)t6);
    t6 = (t0 + 5456U);
    t8 = ieee_p_1242562249_sub_4437083849341520093_1035706684(IEEE_P_1242562249, t5, t7, t6);
    t9 = ieee_p_1242562249_sub_3044623114557194624_1035706684(IEEE_P_1242562249, t4, t1, t8, t5);
    if (t9 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(30, ng0);
    t2 = (t0 + 1512U);
    t3 = *((char **)t2);
    t2 = (t0 + 3448);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t3, 3U);
    xsi_driver_first_trans_fast_port(t2);
    xsi_set_current_line(31, ng0);
    t2 = (t0 + 1192U);
    t3 = *((char **)t2);
    t2 = (t0 + 5456U);
    t4 = ieee_p_1242562249_sub_4437083849341520093_1035706684(IEEE_P_1242562249, t1, t3, t2);
    t6 = (t0 + 3384);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t4, 6U);
    xsi_driver_first_trans_fast_port(t6);

LAB3:    t2 = (t0 + 3304);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(26, ng0);
    t11 = (t0 + 1032U);
    t12 = *((char **)t11);
    t11 = (t0 + 5440U);
    t13 = ieee_p_1242562249_sub_4437083849341520093_1035706684(IEEE_P_1242562249, t10, t12, t11);
    t14 = (t0 + 3384);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t13, 6U);
    xsi_driver_first_trans_fast_port(t14);
    xsi_set_current_line(27, ng0);
    t2 = (t0 + 1352U);
    t3 = *((char **)t2);
    t2 = (t0 + 3448);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t3, 3U);
    xsi_driver_first_trans_fast_port(t2);
    goto LAB3;

}


extern void work_a_2260338868_1697392497_init()
{
	static char *pe[] = {(void *)work_a_2260338868_1697392497_p_0};
	xsi_register_didat("work_a_2260338868_1697392497", "isim/minimum_13comp_isim_beh.exe.sim/work/a_2260338868_1697392497.didat");
	xsi_register_executes(pe);
}
