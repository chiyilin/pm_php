<?php

namespace app\api\controller;

use app\common\model\ProdTaocMiddle;
use app\common\model\ProdList;
use app\common\model\Product as ProductModel;
use app\common\model\ProductSample;
use app\common\model\ProductClass;
use app\common\model\ProductBanner;
use app\common\model\ProdListComment;
use app\common\model\ProdListCommentImg;
use app\common\model\User;
use app\common\model\UserCollection;
use app\common\model\UserDingy;
use app\common\model\ProductTaoc;
use app\common\model\Config as ConfigModel;
use app\common\model\UserMessage;
use app\common\model\UserOfferPrice;
use app\common\WxPay;
use app\common\model\Setting;
use think\Config;
use think\Controller;
use think\Exception;
use think\Loader;
use think\Request;
use app\common\model\Coupon;
use app\common\model\ProdListBetween;

class Product extends Controller
{
    /**
     * 产品详情信息展示（一口价、拍卖商品公用）
     */
    public function details(Request $request)
    {
        $setting = Setting::find();
        $param = $request->param();
//        halt($param);
        $face = Config::get('config')['face'];
        $data = ProductModel::with(['productBanner' => function ($query) {
            $query->field('product_id,url')->order(['sort' => 'desc', 'add_time' => 'desc']);
        }])->withCount(['userCollection' => function ($query) {
            $query->where(['user_id' => input('param.user_id')]);
        }])->limit(1)->find($param['id']);
        $data['product_face'] = $face[$data['product_face']];
        $data['product_start_time'] = date('Y.m.d H:i', $data['product_start_time']);
        $data['product_end_time'] = date('Y.m.d H:i', $data['product_end_time']);
//        halt($data->toArray());
        //如果是竞价商品则查看最近一条出价记录。
        if ($data['product_type'] == 1) {
            $offerInfo = UserOfferPrice::where([
                'product_id' => $data['product_id']
            ])->order([
                'offer_money' => 'desc',
                'offer_id' => 'desc'
            ])->limit(1)->find();
            if ($offerInfo) {
                $data['product_money'] = $offerInfo['offer_money'];
            }
        }
        $config = ConfigModel::limit(1)->find();
        $result = [
            'data' => $data,
            'setting' => $setting,
        ];
        $this->result($result, 200, 'success');
    }

    /**
     * 单件商品一口价支付购买
     */
    public function nowBuy(Request $request)
    {
        $time = time();
        $param = $request->param();
//        $param = $request->param();
        //商品信息
        $prodInfo = ProductModel::where(['product_id' => ["in", input('param.id/a')]])->select();
        $prodCountMoney = array_sum(array_column($prodInfo->toArray(), 'product_money'));
//        halt($prodCountMoney);
        $userInfo = User::limit(1)->find($param['user_id']);
        $ProdListCreateArr = [
            'user_id' => $param['user_id'],
            'order_number' => order_number($param['user_id']),
            'express_money' => $param['express_money'],
            'express_id' => $param['express_id'],
            'product_money' => $prodCountMoney + $param['express_money'],
            'pay_money' => $prodCountMoney + $param['express_money'],
            'list_type' => 2,
            'list_add_time' => $time,
        ];
        if (!empty($param['coupon_id'])) {
            $couponInfo = Coupon::where([
                'coupon_id' => $param['coupon_id'],
                'user_id' => $param['user_id'],
                'coupon_status' => 1,
                'need_money' => ['<=', 3.33],
                'can_use_start_time' => ['<=', $time],
                'can_use_expire_time' => ['>=', $time],
            ])->limit(1)->find();

            if (!empty($couponInfo)) {
                $ProdListCreateArr['coupon_money'] = $couponInfo['money'];
                $ProdListCreateArr['pay_money'] = $ProdListCreateArr['product_money'] - $couponInfo['money'];
                $ProdListCreateArr['coupon_id'] = $param['coupon_id'];
            }
        }
        $ProdListInfo = ProdList::create($ProdListCreateArr);
        $ProdListBetween = [];
        foreach ($prodInfo as $index => $item) {
            $ProdListBetween[$index]['user_id'] = $param['user_id'];
            $ProdListBetween[$index]['product_info'] = serialize($item);
            $ProdListBetween[$index]['product_id'] = $item['product_id'];
            $ProdListBetween[$index]['result_money'] = $item['product_money'];
            $ProdListBetween[$index]['order_number'] = order_number($param['user_id'], $item['product_id']);
//            $ProdListBetween[$index]['server_money'] = $ProdListBetween[$index]['result_money'] * (1 + $server_rate);
            $ProdListBetween[$index]['total_price'] = $ProdListBetween[$index]['result_money'];
            $ProdListBetween[$index]['express_id'] = $param['express_id'];
            if (empty($product_info['express_info'])) {
                $product_info['express_info'] = Config::get('express');
            }
            $ProdListBetween[$index]['express_money'] = $product_info['express_info'][$param['express_id']]['money'];
            $ProdListBetween[$index]['pay_money'] = $ProdListBetween[$index]['total_price'] + $ProdListBetween[$index]['express_money'];
            $ProdListBetween[$index]['list_id'] = $ProdListInfo['list_id'];
            $ProdListBetween[$index]['list_type'] = $ProdListInfo['list_type'];
            $ProdListBetween[$index]['add_time'] = time();
        }
        $ProdListBetweenObj = new ProdListBetween();
        $ProdListBetweenObj->saveAll($ProdListBetween);
        Loader::import('wxpay.lib.WxPay', EXTEND_PATH, '.Api.php');
        Loader::import('wxpay.example.WxPay', EXTEND_PATH, '.JsApiPay.php');
        //统一下单
        $configModel = ConfigModel::find();
        $config = new \WxPayConfig($configModel);
        $tools = new \JsApiPay();
        $input = new \WxPayUnifiedOrder();
        $input->SetBody("泉拍在线商品订购" . $ProdListCreateArr['order_number']);
        $input->SetAttach($ProdListInfo['list_id']);
        $input->SetOut_trade_no($ProdListInfo['order_number']);
        $input->SetTotal_fee($ProdListInfo['pay_money'] * 100);
        $input->SetTime_start(date("YmdHis", $time));
        $input->SetTime_expire(date("YmdHis", $time + 600));
        $input->SetNotify_url(getHttpHost() . "/api/notify/videobuynotify");
        $input->SetTrade_type("JSAPI");
        $input->SetOpenid($userInfo['openid']);
        $order = \WxPayApi::unifiedOrder($config, $input);
        $jsApiParameters = $tools->GetJsApiParameters($configModel, $order);
        ProdList::where(['list_id' => $ProdListInfo['list_id']])->update(['pay_requset_info' => json_encode($jsApiParameters)]);
        return $this->result($jsApiParameters, 200, 'success');
    }

    /**
     * 预下单支付信息
     */
    public function cartInfo(Request $request)
    {
        $param = $request->param();
        $face = Config::get('config')['face'];
        //商品信息
        $data = ProductModel::where(['product_id' => ['in', $param['id']]])->field('product_id,product_name,product_money,product_cover,product_start_time,product_end_time,express_info')->select();
        foreach ($data as $key => $value) {
            $data[$key]['product_start_time'] = date('Y.m.d H:i', $value['product_start_time']);
            $data[$key]['product_end_time'] = date('Y.m.d H:i', $value['product_end_time']);
        }
        $time = time();
        $need_money = array_sum(array_column($data->toArray(), 'product_money'));
        //查找可用优惠券
        $countCoupon = Coupon::where([
            'user_id' => $param['user_id'],
            'coupon_status' => 1,
            'need_money' => ['<=', $need_money],
            'can_use_start_time' => ['<=', $time],
            'can_use_expire_time' => ['>=', $time],
        ])->count();
        //邮费信息部分
        $expressMoneyArr = [];
        $defaultExpress = Config::get('express');
        $expressArrInfo = array_column($data->toArray(), 'express_info');
        foreach ($expressArrInfo as $key => $value) {
            if (empty($value)) {
                $expressArrInfo[$key] = $defaultExpress;
            } else {
                $expressArrInfo[$key] = json_decode($value, true);
            }
            $expressMoneyArr[$key] = array_column($expressArrInfo[$key], 'money');
            foreach ($defaultExpress as $k => $v) {
                $defaultExpress[$k]['current'] = $expressArrInfo[$key][$k]['current'];
            }
        }
        foreach ($defaultExpress as $key => $value) {
            $defaultExpress[$key]['money'] = array_sum(array_column($expressMoneyArr, $key));
        }
        $this->result(['data' => $data, 'countCoupon' => $countCoupon, 'defaultExpress' => $defaultExpress], 200, 'success');
    }
}