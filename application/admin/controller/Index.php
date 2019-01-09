<?php

namespace app\admin\controller;

use think\Config;
use think\Controller;
use think\Cookie;
use think\Loader;
use think\Session;
use app\common\model\ConfigFx;
use app\common\model\User;
use app\common\model\Product;
use app\common\model\ProdList;
use app\common\model\UserMessage;
use app\common\model\UserRocad;


class Index extends Controller
{
    public function index()
    {
        $page = Config::get('adminpage');
        Cookie::set('webname', $page['name']);
        if (!Session::get('admin_id')) {
            $this->redirect('login/login');
        }
        return $this->fetch();
    }

    public function welcome()
    {
        return $this->fetch();
        Loader::import('weixinpay.lib.WxPay', EXTEND_PATH, '.Api.php');
        Loader::import('weixinpay.example.WxPay', EXTEND_PATH, '.JsApiPay.php');
        //统一下单
        $tools = new \JsApiPay();
        $input = new \WxPayUnifiedOrder();
        $input->SetBody("课程订购-");
//        $input->SetAttach("test");
        $time = time();
        $input->SetOut_trade_no(rand(1000, 9999));
        $input->SetTotal_fee(0.01 * 100);
//        $input->SetTotal_fee($res['pay_money']*100);
        $input->SetTime_start(date("YmdHis", $time));
        $input->SetTime_expire(date("YmdHis", $time + 600));
//        $input->SetGoods_tag("test");
        $input->SetNotify_url(getHttpHost() . "/api/notify/videobuynotify");
        $input->SetTrade_type("JSAPI");
        $input->SetOpenid('opUgV0RfEy_keN4JFrJGunIjAZdY');
//        halt($input);
        $order = \WxPayApi::unifiedOrder($input);
        $jsApiParameters = $tools->GetJsApiParameters($order);
        halt($jsApiParameters);
        $order['timeStamp'] = (string)$time;

    }
}