<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/11/17
 * Time: 16:49
 */

$crond_list = array(
    //每分钟
    '*' => [
        'app\command\Minutes::checkList',
        'app\command\Hour::Prod',
        /*'app\command\Minutes::firstTest',
        'app\command\Minutes::secondTest',
        'app\command\Minutes::clearProdList',*/
    ],
    //每小时---------
    '*:00' => [
        //判断某个场次的拍卖藏品是否结束
        'app\command\Hour::Prod',
    ],
    //每周 ------------
    '00:00' => [],
    //每月--------
    '*-01 00:00' => [],
);

return $crond_list;