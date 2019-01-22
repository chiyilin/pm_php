<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/5
 * Time: 14:24
 */
return [
    'list_type' => [
        1 => ['msg' => '竞价商品订单', 'css' => 'layui-btn-warning'],
        2 => ['msg' => '一口价商品订单', 'css' => 'layui-btn-normal'],
    ],
    'is_pay' => [
        1 => ['msg' => '未支付', 'css' => 'layui-btn-danger'],
        2 => ['msg' => '已支付', 'css' => 'layui-btn-normal'],
        3 => ['msg' => '已申请发货', 'css' => 'layui-btn-warm'],
        4 => ['msg' => '已发货', 'css' => 'layui-btn-warning'],
        5 => ['msg' => '已确认收货', 'css' => 'layui-btn-normal'],
        6 => ['msg' => '已申请委托', 'css' => 'layui-btn-warning'],
    ],
    'user_lines_redord_type' => [
        1 => ['msg' => '充值', 'css' => 'layui-btn-danger'],
        2 => ['msg' => '消费', 'css' => 'layui-btn-normal'],
        3 => ['msg' => '竞拍结束退回', 'css' => 'layui-btn-warm'],
    ]
];