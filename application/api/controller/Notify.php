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
    public function buynotify()
    {
        Loader::import('wxpay.lib.WxPayNotifyBuy', EXTEND_PATH);
        $a = new \WxPayNotifyBuy();
        $a->Handle(false);
    }
}