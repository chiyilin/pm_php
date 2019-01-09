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
    /*    // 会员充值回调
        public function memberRechargeNotify()
        {
            require_once ROOT_PATH . 'weixinpay/lib/WxPayNotifyMember.php';
            $a = new \WxPayNotifyMember();
            $a->Handle(false);
        }

        // 购买产品回调
        public function buyNotify()
        {
            require_once ROOT_PATH . 'weixinpay/lib/WxPayNotifyBuy.php';
            $a = new \WxPayNotifyBuy();
            $a->Handle(false);
        }*/

    // 视频购买回调
    public function videobuynotify()
    {
        Loader::import('wxpay.lib.WxPayNotifyBuy', EXTEND_PATH);
        $a = new \WxPayNotifyBuy();
        $a->Handle(false);
    }

    //报名报考支付回调
    public function applypaynotify()
    {
        require_once ROOT_PATH . 'weixinpay/lib/WxPayNotifyApply.php';
        $a = new \WxPayNotifyApply();
        $a->Handle(false);
    }

    //
    public function memberbuynotify()
    {
        require_once ROOT_PATH . 'weixinpay/lib/WxPayNotifyMember.php';
        $a = new \WxPayNotifyMember();
        $a->Handle(false);
    }

    public function buynotify()
    {
        Loader::import('weixinpay.lib.WxPayNotifyMember', EXTEND_PATH);
        $a = new \WxPayNotifyMember();
        $a->Handle(false);
    }
}