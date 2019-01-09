<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/2
 * Time: 10:22
 */

namespace app\api\controller;


use think\Controller;
use app\common\model\Coupon as CouponModel;
use think\Request;

class Coupon extends Controller
{
    public function index(Request $request)
    {
        $param = $request->param();
        $time = time();
        $data = CouponModel::where([
            'user_id' => $param['user_id'],
            'coupon_status' => 1,
            'can_use_start_time' => ['<=', $time],
            'can_use_expire_time' => ['>=', $time],
        ])->select();
        foreach ($data as $key => $value) {
            $data[$key]['can_use_start_time'] = date("Y-m-d H:i", $value['can_use_start_time']);
            $data[$key]['can_use_expire_time'] = date("Y-m-d H:i", $value['can_use_expire_time']);
        }
        $this->result(compact('data'), 200, 'success');
    }

    public function details(Request $request)
    {
        $param = $request->param();
        $time = time();
        $data = CouponModel::limit(1)->find($param['id']);
        if ($data['can_use_start_time'] > $time) {
            $this->result([], 400, '当前无法使用此优惠券。');
        } elseif ($data['can_use_expire_time'] < $time) {
            $this->result([], 400, '此优惠券已过期。');
        } elseif ($data['coupon_status'] != 1) {
            $this->result([], 400, '此优惠券已失效。');
        }
        $this->result($data, 200, 'success');
    }
}