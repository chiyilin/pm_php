<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/11
 * Time: 11:26
 */

namespace app\api\controller;


use app\common\model\UserRecharge;
use think\Controller;
use app\common\model\User;
use app\common\model\Setting;
use app\common\model\Config as ConfigModel;
use think\Loader;
use think\Request;

class Recharge extends Controller
{
    /**
     * 竞拍额度充值页面
     */
    public function index(Request $request)
    {
        $param = $request->param();
        $setting = Setting::limit(1)->find();
        $userInfo = User::where(['user_id' => $param['user_id']])->limit(1)->find();
        $this->result(compact('setting', 'userInfo'), 200, 'success');
    }

    /**
     * 竞拍额度充值统一下单
     */
    public function unifiedOrder(Request $request)
    {
        $param = $request->param();
        $time = time();
        $userInfo = User::where(['user_id' => $param['user_id']])->limit(1)->find();
        $UserRechargeInfo = UserRecharge::create([
            'order_number' => order_number($userInfo['user_id']),
            'user_id' => $userInfo['user_id'],
            'lines' => $param['lines'],
            'total_price' => $param['total_price'],
            'add_time' => $time,
        ]);
        Loader::import('wxpay.lib.WxPay', EXTEND_PATH, '.Api.php');
        Loader::import('wxpay.example.WxPay', EXTEND_PATH, '.JsApiPay.php');
        //统一下单
        $configModel = ConfigModel::find();
        $config = new \WxPayConfig($configModel);
        $tools = new \JsApiPay();
        $input = new \WxPayUnifiedOrder();
        $input->SetBody("泉拍在线竞拍额度充值" . $UserRechargeInfo['order_number']);
        $input->SetAttach($UserRechargeInfo['user_recharge_id']);
        $input->SetOut_trade_no($UserRechargeInfo['order_number']);
        $input->SetTotal_fee($UserRechargeInfo['total_price'] * 100);
        $input->SetTime_start(date("YmdHis", $time));
        $input->SetTime_expire(date("YmdHis", $time + 600));
        $input->SetNotify_url(getHttpHost() . "/api/notify/rechargeNotify");
        $input->SetTrade_type("JSAPI");
        $input->SetOpenid($userInfo['openid']);
        $order = \WxPayApi::unifiedOrder($config, $input);
        $jsApiParameters = $tools->GetJsApiParameters($configModel, $order);

        $this->result($jsApiParameters, 200, 'success');
    }

}