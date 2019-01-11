<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/9/12
 * Time: 10:11
 */

namespace app\api\controller;

use think\Controller;
use think\Loader;

class Notify extends Controller
{
    /**
     * 订单支付回调
     */
    public function buynotify()
    {
        Loader::import('wxpay.lib.WxPayNotifyBuy', EXTEND_PATH);
        $a = new \WxPayNotifyBuy();
        $a->Handle(false);
    }

    /**
     * 竞拍额度充值回调
     */
    public function rechargeNotify()
    {
        Loader::import('wxpay.lib.WxPayNotifyRecharge', EXTEND_PATH);
        $a = new \WxPayNotifyRecharge();
        $a->Handle(false);
    }
}