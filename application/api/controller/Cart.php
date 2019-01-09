<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/4
 * Time: 9:36
 */

namespace app\api\controller;

use phpDocumentor\Reflection\Types\Object_;
use think\Config;
use think\Controller;
use think\Request;
use think\Loader;
use app\common\model\UserGetProd;
use app\common\model\Product as ProductModel;
use app\common\model\Coupon;
use app\common\model\ProdList;
use app\common\model\User;
use app\common\model\Config as ConfigModel;
use app\common\model\ProdListBetween;

class Cart extends Controller
{
    /**
     * 得标商品列表
     */
    public function cart(Request $request)
    {
        $param = $request->param();
        //待支付、待发货、待收货
        if ($param['current'] == 0) {
            $data = UserGetProd::with('product')->where([
                'user_id' => $param['user_id'],
                'is_pay' => ['<', 2],
            ])->select();
        } elseif ($param['current'] == 1) {
            $data = ProdListBetween::where([
                'user_id' => $param['user_id'],
                'is_pay' => 2,
            ])->select();
            foreach ($data as $key => $value) {
                $data[$key]['product_info'] = unserialize($value['product_info']);
            }
        } elseif ($param['current'] == 2) {
            $data = ProdListBetween::where([
                'user_id' => $param['user_id'],
                'is_pay' => ['in', '3,4'],
            ])->select();
            foreach ($data as $key => $value) {
                $data[$key]['product_info'] = unserialize($value['product_info']);
            }
        }
        $status = Config::get('status');
        $this->result(['data' => $data, 'status' => $status], 200, 'success');
    }

    /**
     * 待支付展示
     */
    public function cartInfo(Request $request)
    {
        $param = $request->param();
        $data = UserGetProd::with(['product' => function ($query) {
            $query->field(['product_id,product_name,product_money,product_cover,product_start_time,product_end_time,express_info']);
        }])->where([
            'get_id' => ['in', $param['id']],
            'user_id' => $param['user_id']
        ])->select();
        foreach ($data as $key => $value) {
            $data[$key]['product']['product_start_time'] = date('Y.m.d H:i', $value['product']['product_start_time']);
            $data[$key]['product']['product_end_time'] = date('Y.m.d H:i', $value['product']['product_end_time']);
        }
        $time = time();
        $need_money = array_sum(array_column($data->toArray(), 'total_price'));
        //查找可用优惠券数量
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
        $expressArrInfo = array_column(array_column($data->toArray(), 'product'), 'express_info');
        foreach ($expressArrInfo as $key => $value) {
            if (empty($value)) {
                $expressArrInfo[$key] = $defaultExpress;
            } else {
                $expressArrInfo[$key] = json_decode($value, true);
            }
            $expressMoneyArr[$key] = array_column($expressArrInfo[$key], 'money');
        }
        foreach ($defaultExpress as $key => $value) {
            $defaultExpress[$key]['money'] = array_sum(array_column($expressMoneyArr, $key));
        }
        $this->result(['data' => $data, 'countCoupon' => $countCoupon, 'defaultExpress' => $defaultExpress], 200, 'success');
    }

    /**
     * 微信支付预下单
     */
    public function nowBuy(Request $request)
    {
        $time = time();
        $param = $request->param();
        $prodList = UserGetProd::with('product')->where(['get_id' => ["in", input('param.id/a')]])->select();
        $prodCountMoney = array_sum(array_column($prodList->toArray(), 'total_price'));
        $userInfo = User::limit(1)->field('user_id,openid')->find($param['user_id']);
        $ProdListCreateArr = [
            'user_id' => $param['user_id'],
            'order_number' => order_number($param['user_id']),
            'express_money' => $param['express_money'],
            'express_id' => $param['express_id'],
            'product_money' => $prodCountMoney + $param['express_money'],
            'pay_money' => $prodCountMoney + $param['express_money'],
            'list_type' => 1,
            'list_add_time' => $time,
        ];
        if (!empty($param['coupon_id'])) {
            $couponInfo = Coupon::where([
                'coupon_id' => $param['coupon_id'],
                'user_id' => $param['user_id'],
                'coupon_status' => 1,
                'need_money' => ['<=', $prodCountMoney],
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
        foreach ($prodList as $index => $item) {
            $ProdListBetween[$index]['product_id'] = $item['product_id'];
            $product_info = ProductModel::limit(1)->find($item['product_id']);
            if (!empty($product_info)) {
                $ProdListBetween[$index]['product_info'] = serialize($product_info->toArray());
            }
            $ProdListBetween[$index]['get_id'] = $item['get_id'];;
            $ProdListBetween[$index]['list_id'] = $ProdListInfo['list_id'];
            $ProdListBetween[$index]['user_id'] = $param['user_id'];
            $ProdListBetween[$index]['add_time'] = time();
        }
        (new ProdListBetween())->saveAll($ProdListBetween);
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
        $input->SetNotify_url(getHttpHost() . "/api/notify/buynotify");
        $input->SetTrade_type("JSAPI");
        $input->SetOpenid($userInfo['openid']);
        $order = \WxPayApi::unifiedOrder($config, $input);
        $jsApiParameters = $tools->GetJsApiParameters($configModel, $order);
//        $order['prepay_id'];
        ProdList::where(['list_id' => $ProdListInfo['list_id']])->update(['pay_requset_info' => json_encode($jsApiParameters)]);
        return $this->result($jsApiParameters, 200, 'success');
    }

    public function nowBuy2(Request $request)
    {
        $time = time();
        $param = $request->param();
        //得标的商品信息
        $getProdInfo = UserGetProd::with('product')->where(['get_id' => ["in", input('param.id/a')]])->select();
        $prodCountMoney = array_sum(array_column($getProdInfo->toArray(), 'total_price'));
        $userInfo = User::limit(1)->field('user_id,openid')->find($param['user_id']);
        $ProdListCreateArr = [
            'user_id' => $param['user_id'],
            'order_number' => order_number($param['user_id']),
            'express_money' => $param['express_money'],
            'express_id' => $param['express_id'],
            'product_money' => $prodCountMoney + $param['express_money'],
            'pay_money' => $prodCountMoney + $param['express_money'],
            'list_type' => 1,
            'list_add_time' => $time,
        ];
        if (!empty($param['coupon_id'])) {
            $couponInfo = Coupon::where([
                'coupon_id' => $param['coupon_id'],
                'user_id' => $param['user_id'],
                'coupon_status' => 1,
                'need_money' => ['<=', $prodCountMoney],
                'can_use_start_time' => ['<=', $time],
                'can_use_expire_time' => ['>=', $time],
            ])->limit(1)->find();
            if (!empty($couponInfo)) {
                $ProdListCreateArr['coupon_money'] = $couponInfo['money'];
                $ProdListCreateArr['pay_money'] = $ProdListCreateArr['product_money'] - $couponInfo['money'];
                $ProdListCreateArr['coupon_id'] = $param['coupon_id'];
            }
        }
        //总订单
        $ProdListInfo = ProdList::create($ProdListCreateArr);
        $ProdListBetween = [];
        foreach ($getProdInfo as $index => $item) {
            $ProdListBetween[$index]['product_id'] = $item['product_id'];
            $product_info = $item['product']->toArray();
            if (!empty($product_info)) {
                $ProdListBetween[$index]['product_info'] = serialize($product_info);
            }
            $ProdListBetween[$index]['result_money'] = $item['result_money'];
            $ProdListBetween[$index]['order_number'] = order_number($param['user_id'], $item['product_id']);
            $ProdListBetween[$index]['server_money'] = $item['server_money'];
            $ProdListBetween[$index]['total_price'] = $item['total_price'];
            $ProdListBetween[$index]['express_id'] = $param['express_id'];
            if (empty($product_info['express_info'])) {
                $product_info['express_info'] = Config::get('express');
            } else {
                $product_info['express_info'] = json_decode($product_info['express_info'], true);
            }
            $ProdListBetween[$index]['express_money'] = $product_info['express_info'][$param['express_id']]['money'];
            $ProdListBetween[$index]['pay_money'] = $item['total_price'] + $ProdListBetween[$index]['express_money'];
            $ProdListBetween[$index]['get_id'] = $item['get_id'];
            $ProdListBetween[$index]['list_id'] = $ProdListInfo['list_id'];
            $ProdListBetween[$index]['list_type'] = $ProdListInfo['list_type'];
            $ProdListBetween[$index]['user_id'] = $param['user_id'];
            $ProdListBetween[$index]['add_time'] = time();
        }
        (new ProdListBetween())->saveAll($ProdListBetween);
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
        $input->SetNotify_url(getHttpHost() . "/api/notify/buynotify");
        $input->SetTrade_type("JSAPI");
        $input->SetOpenid($userInfo['openid']);
        $order = \WxPayApi::unifiedOrder($config, $input);
        $jsApiParameters = $tools->GetJsApiParameters($configModel, $order);
//        $order['prepay_id'];
        ProdList::where(['list_id' => $ProdListInfo['list_id']])->update(['pay_requset_info' => json_encode($jsApiParameters)]);
        return $this->result($jsApiParameters, 200, 'success');
    }

    /**
     * 订单操作（多项、单项通用）
     * @param Object $request
     */
    public function applySendOut(Request $request)
    {
        $where = $update = [];
        $param = $request->param();
        $where['between_id'] = ['in', $param['between_id']];
        $where['user_id'] = $param['user_id'];
        if ($param['current'] == 1) {
            $where['is_pay'] = 2;
            $update['is_pay'] = 3;
        } elseif ($param['current'] == 2) {
            $where['is_pay'] = ['in', '3,4'];
            $update['is_pay'] = 5;
            $update['on_hand_time'] = time();
        }
        $data = ProdListBetween::where($where)->update($update);
        $data ? $this->result([], 200, '操作成功') : $this->result([], 400, '操作失败！');
    }
}