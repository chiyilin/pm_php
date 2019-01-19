<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/16
 * Time: 13:30
 */


return [


    1 => [
        'addr' => '/pages/index/index',
        'desc' => '首页',
        'param' => false,
        'ext' => [],
        'ext_tips' => '',
    ],
    [
        'addr' => "/pages/transaction/transaction",
        'desc' => '交易中心',
        'param' => false,
        'ext' => [],
        'ext_tips' => '',
    ],
    [
        'addr' => "/pages/mine/paid/paid",
        'desc' => '待支付、待发货、待收货',
        'param' => true,
        'ext' => ['current'],
        'ext_tips' => 'current：1：待支付；2：待发货；3：待收货',
    ],
    [
        'addr' => "/pages/mine/mine",
        'desc' => '个人中心',
        'param' => false,
        'ext' => [],
        'ext_tips' => '',
    ],
    [
        'addr' => "/pages/mine/recharge/recharge",
        'desc' => '竞拍额度充值',
        'param' => false,
        'ext' => [],
        'ext_tips' => '',
    ],
    [
        'addr' => "/pages/mine/TransactionRecords/TransactionRecords",
        'desc' => '交易记录',
        'param' => false,
        'ext' => [],
        'ext_tips' => '',
    ],
    [
        'addr' => "/pages/mine/attention/attention",
        'desc' => '我的关注',
        'param' => false,
        'ext' => [],
        'ext_tips' => '',
    ],
    [
        'addr' => "/pages/index/CollectionDetails/CollectionDetails",
        'desc' => '商品详情',
        'param' => true,
        'ext' => ['id'],
        'ext_tips' => '请在此处输入商品ID',
    ],
    [
        'addr' => "/pages/mine/card/card",
        'desc' => '我的优惠券',
        'param' => false,
        'ext' => [],
        'ext_tips' => '',
    ],
    [
        'addr' => "/pages/article/list/list",
        'desc' => '文章列表',
        'param' => false,
        'ext' => [],
        'ext_tips' => '',
    ],
    [
        'addr' => "/pages/article/details/details",
        'desc' => '文章详情',
        'param' => true,
        'ext' => ['id'],
        'ext_tips' => '请在此输入文章详情',
    ],
    [
        'addr' => "/pages/index/BidRecord/BidRecord",
        'desc' => '竞拍商品出价记录',
        'param' => true,
        'ext' => ['id'],
        'ext_tips' => '请在此输入竞拍商品ID',
    ],
    [
        'addr' => "/pages/index/screen/screen",
        'desc' => '分类商品列表',
        'param' => true,
        'ext' => ['id'],
        'ext_tips' => '请在此输入分类ID',
    ],
    [
        'addr' => "/pages/index/category/category",
        'desc' => '全部分类',
        'param' => false,
        'ext' => [],
        'ext_tips' => '',
    ],
    [
        'addr' => "/pages/collection/collection",
        'desc' => '全部专场',
        'param' => false,
        'ext' => [],
        'ext_tips' => '',
    ],
    [
        'addr' => "/pages/collection/coll-details/coll-details",
        'desc' => '专场详情',
        'param' => true,
        'ext' => ['id'],
        'ext_tips' => '请在此输入专场ID',
    ],
    [
        'addr' => "/pages/entrust/entrust",
        'desc' => '委托申请',
        'param' => false,
        'ext' => [],
        'ext_tips' => '',
    ],
    [
        'addr' => "/pages/address/address",
        'desc' => '收货地址列表',
        'param' => false,
        'ext' => [],
        'ext_tips' => '',
    ],
];