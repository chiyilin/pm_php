<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/12/26
 * Time: 14:13
 */

namespace app\command;

use app\common\model\Product;
use app\common\model\User;
use app\common\model\UserLinesRecord;
use app\common\model\UserOfferPrice;
use app\common\model\ProdList;
use app\common\model\UserGetProd;
use app\common\model\Setting;

class Hour
{
    //拍卖商品结束操作
    public static function Prod()
    {
        $time = time();
        //查找当前已经结束的拍卖商品
        $data = Product::where(['product_type' => 1, 'product_end' => 1, 'product_end_time' => ['<=', $time]])->column('product_id');
        dump($data);
        //循环已经结束的商品
        foreach ($data as $key => $value) {
            //查找最高出价
            $res = UserOfferPrice::where(['product_id' => $value])->order(['offer_money' => 'desc', 'offer_add_time' => 'asc'])->limit(1)->find();
            //生成订单(废弃)
            /*ProdList::create([
                'user_id' => $res['user_id'],
                'product_id' => $res['product_id'],
                'pay_money' => $res['offer_money'],
                'list_add_time' => $time,
            ]);*/
            $setting = Setting::limit(1)->find();
            $setting['server_rate'];
            $server_money = $res['offer_money'] * $setting['server_rate'] * 0.01;
            //todo 加入到用户已经得标记录
            UserGetProd::create([
                'user_id' => $res['user_id'],
                'product_id' => $res['product_id'],
                'result_money' => $res['offer_money'],
                'server_money' => $server_money,
                'total_price' => $res['offer_money'] + $server_money,
                'is_pay' => 1,
                'add_time' => $time,

            ]);
            //todo 未得标用户归还竞拍额度
            $UserLinesRecordData = UserLinesRecord::where([
                'user_id' => $res['user_id'],
                'product_id' => $res['product_id'],
                'offer_id' => ['neq', $res['offer_id']]
            ])->select();
            $NewUserLinesRecord = $userLinesData = [];
            foreach ($UserLinesRecordData as $k => $v) {
                $NewUserLinesRecord[$k] = [
                    'user_id' => $v['user_id'],
                    'offer_id' => $v['offer_id'],
                    'type' => 3,
                    'money' => abs($v['money']),
                    'record_add_time' => $time,
                ];
                $userLinesData[$k] = [
                    'user_id' => $v['user_id'],
                    'money' => abs($v['money']),
                ];
            }
            $UserLinesRecord = new UserLinesRecord();
            $UserLinesRecord->saveAll($NewUserLinesRecord);
            foreach ($userLinesData as $k => $v) {
                User::where(['user_id' => $v['user_id']])->setInc('user_lines', $v['money']);
            }
        }
        //todo 更改产品状态为已结束
        Product::where([
            'product_id' => ['in', $data]
        ])->update(['product_end' => 2]);
    }
}