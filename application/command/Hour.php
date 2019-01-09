<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/12/26
 * Time: 14:13
 */

namespace app\command;

use app\common\model\Product;
use app\common\model\UserOfferPrice;
use app\common\model\ProdList;
use app\common\model\UserGetProd;
use app\common\model\Setting;

class Hour
{
    //拍卖结束
    public static function Prod()
    {
        //查找当前已经结束的拍卖商品
        $data = Product::where(['product_type' => 1, 'product_end' => 1, 'product_end_time' => ['<=', time()]])->column('product_id');
        dump($data);
        //循环已经结束的商品
        foreach ($data as $key => $value) {
            //查找最高出价
            $res = UserOfferPrice::where(['product_id' => $value])->order(['offer_money' => 'desc', 'offer_add_time' => 'asc'])->limit(1)->find();
            //生成订单(XXXXX废弃XXXXXX)
            /*ProdList::create([
                'user_id' => $res['user_id'],
                'product_id' => $res['product_id'],
                'pay_money' => $res['offer_money'],
                'list_add_time' => time(),
            ]);*/
            $setting = Setting::limit(1)->find();
            $setting['server_rate'];
            $server_money = $res['offer_money'] * $setting['server_rate'] * 0.01;
            //加入到用户已经得标记录
            UserGetProd::create([
                'user_id' => $res['user_id'],
                'product_id' => $res['product_id'],
                'result_money' => $res['offer_money'],
                'server_money' => $server_money,
                'total_price' => $res['offer_money'] + $server_money,
                'is_pay' => 1,
                'add_time' => time(),

            ]);
        }
        Product::where([
            'product_id' => ['in', $data]
        ])->update(['product_end' => 2]);
    }
}