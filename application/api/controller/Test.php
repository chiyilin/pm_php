<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/10
 * Time: 10:19
 */

namespace app\api\controller;


use think\Controller;
use app\common\model\Coupon;
use app\common\model\ProdListBetween;
use app\common\model\UserGetProd;
use app\common\model\ProdList;

class Test extends Controller
{
    public function test()
    {
        $result = [
            'attach' => 439,
            'transaction_id' => '143322314332231433223',
        ];
        //todo 1.更改并获取最新的订单信息。
        $time = time();
        $ProdList = new ProdList();
        $prodListInfo = $ProdList->where([
            'list_id' => $result['attach'],
            'is_pay' => 1
        ])->limit(1)->find();
        if ($prodListInfo == null) {
            return false;
        }
        $prodListInfo->is_pay = 2;
        $prodListInfo->transaction_id = $result['transaction_id'];
        $prodListInfo->list_pay_time = $time;
        $prodListInfo->save();

        //todo 2.如果用了优惠券付款，则将优惠券状态改为已用。
        if (!empty($prodListInfo['coupon_id'])) {
            Coupon::where(['coupon_id' => $prodListInfo['coupon_id']])->update(['coupon_status' => 2]);
        }

        //todo 3.更改订单中间表的信息。
        ProdListBetween::where([
            'list_id' => $result['attach'],
            'is_pay' => 1
        ])->update([
            'is_pay' => 2,
            'transaction_id' => $result['transaction_id'],
            'pay_time' => $time,
        ]);
        $ProdListBetween = new ProdListBetween();
        $ProdListBetweenInfo = $ProdListBetween->where([
            'list_id' => $result['attach'],
        ])->select();

        //todo 4.如果是竞拍商品，则将用户得标商品标的状态改为已付款。
        $getIDArr = [];
        foreach ($ProdListBetween as $key => $value) {
            if (!empty($value['get_id'])) {
                $getIDArr[] = $value['get_id'];
            }
        }
        if (!empty($getIDArr)) {
            halt($getIDArr);
            UserGetProd::where(['get_id' => ['in', $getIDArr], 'is_pay' => 1])->update(['is_pay' => 2]);
        }

        //todo 5.记录用户总消费额度
    }
}