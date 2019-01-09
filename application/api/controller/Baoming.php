<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/10/11
 * Time: 14:35
 */

namespace app\api\controller;


use app\common\model\Baokao;
use app\common\model\Lists;
use think\Controller;
use app\common\model\Product;
use app\common\model\User;


class baoming extends Controller
{
    /**
     * 报名报考下拉菜单数据
     */
    public function index()
    {
        $state = input('param.state');
        $baoming = Baokao::where('display', '1')->where('baokao_state', $state)->order('sort')->select();
        foreach ($baoming as $key=>$value){
            if($value['default_chose']==2){
                $defaultIndex=$key;
            }
        }

        return $this->result([
            'baoming' => $baoming,
            'defaultIndex'=>!empty($defaultIndex)||$defaultIndex==0?$defaultIndex:null
        ], 200, '信息获取成功');
    }

    /**
     * 支付报名报考
     */
    public function applyPay()
    {
        $baokao_id = input('param.baokao_id') ? input('param.baokao_id') : '';
        $user_id = input('param.user_id') ? input('param.user_id') : '';
        $baokao = Baokao::where('display', '1')->where('baokao_id', $baokao_id)->limit(1)->find();
        $res = Lists::create([
            'baokao_id' => $baokao_id,
            'user_id' => $user_id,
            'order_number' => date('Ymd', time()) . time() . $user_id,
//            'transaction_id' => date('Y-m-d', time()) . time() . input('param.user_id'),
            'list_state' => $baokao['baokao_state'],
            'pay_money' => $baokao['baokao_money'],
            'addtime' => time(),
        ]);
        $userInfo = User::find($res['user_id']);
        require_once ROOT_PATH . 'weixinpay/lib/WxPay.Api.php';
        require_once ROOT_PATH . "weixinpay/example/WxPay.JsApiPay.php";
        //   统一下单
        $input = new \WxPayUnifiedOrder();
        $input->SetBody($baokao->baokao_name);
//        $input->SetAttach($baokao->baokao_name);
        $time = time();
        $input->SetOut_trade_no($res['order_number']);
        $input->SetTotal_fee($baokao->baokao_money * 100);
//        $input->SetTotal_fee($res['pay_money']*100);
        $input->SetTime_start(date("YmdHis", $time));
        $input->SetTime_expire(date("YmdHis", $time + 600));
//        $input->SetGoods_tag("test");
        $input->SetNotify_url("http://class.chdmhz.com/api/notify/applypaynotify");
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
        $tmp['timeStamp'] = "$time";
        $order['sign'] = \WxPayApi::sign($tmp);
        $order['list_id'] = $res->list_id;
        /**
         * 微信小程序再次签名<!--END-->
         */
        Lists::where('list_id', $res->list_id)->update(['prepay_id' => $order['prepay_id']]);
        $this->result($order, 200, 'success');
    }

    /*
     * 报名成功页面展示
     */
    public function chenggong()
    {
        $listInfo = Lists::find(input('param.list_id'));
        $baokao_id = $listInfo->baokao_id;
        $user_id = input('param.user_id') ? input('param.user_id') : '';
        $baokao = Baokao::where('display', '1')->where('baokao_id', $baokao_id)->limit(1)->find();
        $user = User::with('usersmrz')->where('user_id', $user_id)->limit(1)->find();
        $this->result(['baokao' => $baokao, 'user' => $user,], 200, 'success');
    }

    /*
     * 报名详情
     */
    public function baoming()
    {
        $id = input("param.baomingid");
        $user_id = input('param.user_id');
        $baomings = Baokao::with(['lists' => function ($query) {
            $query->where([
                'user_id' => input('param.user_id'),
                'is_pay' => 2,
            ]);
        }])->where('display', '1')->where('baokao_id', $id)->find()->toArray();
        $baomings['baokao_start_time'] = date('Y-m-d', $baomings['baokao_start_time']);
        $baomings['baokao_end_time'] = date('Y-m-d', $baomings['baokao_end_time']);
//        $baomings['baokao_xuzhi'] = json_decode($baomings['baokao_xuzhi'], true);
        $user = User::with('usersmrz')->where('user_id', $user_id)->find();
        return $this->result([
            'baomings' => $baomings,
            'user' => $user,
        ], 200, '产品信息获取成功');
    }

    /**
     * 报名管理
     */
    public function guanli()
    {
        $user_id = input("param.user_id");
        $baoming = Lists::with('user,baokao,usersmrz')->where("user_id", $user_id)->order('list_state,addtime')->select();
        for ($i = 0; $i < count($baoming); $i++) {
            $baoming[$i]['addtime'] = date('Y-m-d', $baoming[$i]['addtime']);
            $temArr = json_decode($baoming[$i]['baokao']['baokao_xuzhi'], true);
            $temStr = '';
            if (!is_array($temArr)) continue;
            foreach ($temArr as $k => $v) {
                $temStr .= !empty($v['image']) ? ' [图片] ' : $v['text'];
            }
            $baoming[$i]['baokao']['baokao_xuzhi'] = $temStr;
        }
        return $this->result($baoming, 200, '报名管理获取成功');
    }

    /*
     * 报名详情
     */
    public function xiangqing()
    {
        $list_id = input('param.list_id');
        $list = Lists::with('user,baokao,usersmrz')->where('list_id', $list_id)->limit(1)->find();
        $list['addtime'] = date('Y-m-d', $list['addtime']);
        $list['baokao']['baokao_xuzhi'] = json_decode($list['baokao']['baokao_xuzhi'], true);
        return $this->result(['list' => $list], 200, '报名详情获取成功');
    }
}