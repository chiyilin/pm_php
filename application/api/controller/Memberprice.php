<?php

namespace app\api\controller;

use app\common\model\User;
use app\common\model\UserMessage;
use app\common\model\ProdListComment;
use app\common\model\MemberPrice as MemberPriceModel;
use app\common\model\UserRecord;

use think\Controller;
use think\Request;
use think\Config;


class Memberprice extends Controller
{
    /**
     * 会员充值列表
     */
    public function index(Request $request)
    {
        $param = $request->post();
        $config = Config::get('miniapp')['fxs'];
        $MemberPriceModel = MemberPriceModel::where([])->order('sort desc,add_time')->select();
        $userInfo = User::find($param['user_id']);
        $this->result(compact('MemberPriceModel', 'userInfo','config'), 200, 'success');
    }

    /**
     * 会员充值生成订单
     */
    public function goumai()
    {
        $param = input('param.');
        $memberPriceInfo = MemberPriceModel::find($param['id']);
        $data = [
            'user_id' => $param['user_id'],
            'member_pay_money' => $memberPriceInfo['price'],
            'member_price_id' => $memberPriceInfo['id'],
//            'service_time'=>$memberPriceInfo['time']/(86400*30),


            'service_name' => $memberPriceInfo['name'],
            'order_number' => order_number(),
            'user_record_add_time' => time(),
        ];
//        halt($memberPriceInfo);
        $userInfo = User::get($param['user_id']);
        if($userInfo['fxs_level']>=$memberPriceInfo['level']){
            $this->result([],400,'无需购买！');
        }
//        $data['begin_time']=$userInfo['member_end_time']==0?time():$userInfo->member_end_time;
//        $data['end_time']=$data['begin_time']+$memberPriceInfo['time'];
//        $userInfo->member_end_time=$data['end_time'];
        $res = UserRecord::create($data);
        

        require_once ROOT_PATH . 'weixinpay/lib/WxPay.Api.php';
        require_once ROOT_PATH . "weixinpay/example/WxPay.JsApiPay.php";
        //   统一下单
        $input = new \WxPayUnifiedOrder();
        $input->SetBody("会员购买-" . $memberPriceInfo['name']);
//        $input->SetAttach("test");
        $time = time();
        $input->SetOut_trade_no($res['order_number']);
        $input->SetTotal_fee($res['member_pay_money'] * 100);
//        $input->SetTotal_fee($res['pay_money']*100);
        $input->SetTime_start(date("YmdHis", $time));
        $input->SetTime_expire(date("YmdHis", $time + 600));
//        $input->SetGoods_tag("test");

        $input->SetNotify_url(getHttpHost() . "/api/notify/memberbuynotify");
        $input->SetTrade_type("JSAPI");
        $input->SetOpenid($userInfo['openid']);
        $order = \WxPayApi::unifiedOrder($input);
        $order['timeStamp'] = (string)$time;
        /**
         * 微信小程序再次签名
         */
        $tmp = [];//临时数组用于签名
        $tmp['appId'] = $order['appid'];
        $tmp['nonceStr'] = $order['nonce_str'];
        $tmp['package'] = 'prepay_id=' . $order['prepay_id'];
        $tmp['signType'] = 'MD5';
        $tmp['timeStamp'] = $time;
        $order['sign'] = \WxPayApi::sign($tmp);
        /**
         * 微信小程序再次签名<!--END-->
         */
        //prepay_id 存一下方便发送模板消息
//        ProdList::where('list_id', $res->list_id)->update(['prepay_id' => $order['prepay_id']]);
        $this->result($order, 200, 'success');
    }
}