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

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000001262397980_3383896982_init();
    work_m_00000000001802333847_3037376393_init();
    work_m_00000000000779559210_2841360810_init();
    work_m_00000000004115494171_3904427059_init();
    work_m_00000000003044524592_2885957937_init();
    work_m_00000000003272468119_4127636709_init();
    work_m_00000000003466206277_3363942390_init();
    work_m_00000000000771716391_3146453351_init();
    work_m_00000000004066932434_4241813833_init();
    work_m_00000000001860153035_1186247429_init();
    work_m_00000000002529238738_0112637215_init();
    work_m_00000000004014371867_2725559894_init();
    work_m_00000000001510766771_0143501659_init();
    work_m_00000000002100665382_1907459465_init();
    work_m_00000000002276980972_0010801604_init();
    work_m_00000000003358488462_2137656763_init();
    work_m_00000000002541276039_3198443470_init();
    work_m_00000000000464582732_1818037894_init();
    work_m_00000000001635762346_2181625025_init();
    work_m_00000000002348155787_3027548060_init();
    work_m_00000000000768268988_0148084070_init();
    work_m_00000000001841675396_2364370701_init();
    work_m_00000000001038896778_3877310806_init();
    work_m_00000000002047498008_0258635663_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002047498008_0258635663");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
