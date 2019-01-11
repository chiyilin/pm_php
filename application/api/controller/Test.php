<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/10
 * Time: 10:19
 */

namespace app\api\controller;


use Couchbase\UserSettings;
use think\Controller;
use app\common\model\Coupon;
use app\common\model\ProdListBetween;
use app\common\model\UserGetProd;
use app\common\model\ProdList;
use app\common\model\User;
use app\common\model\CouponSetting;

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
//            'is_pay' => 1
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
        foreach ($ProdListBetweenInfo as $key => $value) {
            if (!empty($value['get_id'])) {
                $getIDArr[] = $value['get_id'];
            }
        }
        if (!empty($getIDArr)) {
            UserGetProd::where(['get_id' => ['in', $getIDArr], 'is_pay' => 1])->update(['is_pay' => 2]);
        }

        //todo 5.记录用户总消费额度,并下发优惠券。
        User::where(['user_id' => $prodListInfo['user_id']])->setInc('grand_total', $prodListInfo['pay_money']);
        $User = new User();
        $userInfo = $User->find($prodListInfo['user_id']);
        $userCouponIdArr = Coupon::where(['user_id' => $userInfo['user_id']])->column('coupon_setting_id');
        $userCouponIdArr = array_filter($userCouponIdArr);
        $CouponSetting = CouponSetting::where([
            'get_this_money' => ['<=', $userInfo['grand_total']],
            'coupon_setting_id' => ['notin', $userCouponIdArr]
        ])->select();
//        halt($userInfo['grand_total']);
//        halt($CouponSetting->toArray());
        $couponArr = [];
        foreach ($CouponSetting as $key => $value) {
            $couponArr[$key]['way'] = 2;
            $couponArr[$key]['user_id'] = $userInfo['user_id'];
            $couponArr[$key]['need_money'] = $value['need_money'];
            $couponArr[$key]['coupon_setting_id'] = $value['coupon_setting_id'];
            $couponArr[$key]['money'] = $value['money'];
            $couponArr[$key]['can_use_start_time'] = $time;
            $couponArr[$key]['can_use_expire_time'] = $time + ($value['useful_life'] * 86400);
            $couponArr[$key]['coupon_status'] = 1;
            $couponArr[$key]['add_time'] = $time;
        }
        $coupon = new Coupon();
        $coupon->saveAll($couponArr);
    }
}