<?php

namespace app\command;

use app\common\model\User;
use app\common\model\Setting;
use app\common\model\ProdList;
use app\common\model\UserGetProd;

class Minutes
{
    public static function firstTest()
    {
        User::create(['nick_name' => 'cron', 'openid' => 'cron', 'lines' => 1]);
        echo 123;
    }

    public static function secondTest()
    {
        echo 456;
    }

    public static function setting()
    {
        User::create(['nick_name' => 'cron', 'openid' => 'cron', 'lines' => 1, 'user_add_time' => time()]);
        echo '设置具体执行的时间';
    }

    /**
     * 一口价商品删除订单超过6分钟未支付
     */
    public static function clearProdList()
    {
        ProdList::where([
            'list_type' => 2,
            'is_pay' => ['<', 2],
            'list_add_time' => ['<=', time() - 300],
        ])->delete();
    }

    /**
     * 竞得商品超时未支付惩罚处理
     */
    public static function checkList()
    {
        $setting = Setting::limit(1)->field('valid_day')->find();
        $validTime = $setting['valid_day'] * 86400;
        // 无效订单：创建时间<=当前时间-存活时间。
        $data = UserGetProd::where([
            'is_pay' => 1,
            'add_time' => ['<=', time() - $validTime]
        ])->field(['user_id', 'product_id', 'get_id'])->select();
        if (!$data->count()) {
            return false;
        }
        $userIdArr = array_filter(array_column($data->toArray(), 'user_id'));
        $prodIdArr = array_filter(array_column($data->toArray(), 'product_id'));
        $getIdArr = array_filter(array_column($data->toArray(), 'get_id'));
        User::where([
            'user_id' => ['in', $userIdArr],
            'user_level' => 1
        ])->update([
            'user_level' => 2
        ]);
        UserGetProd::where(['get_id' => ['in', $getIdArr]])->update(['is_pay' => 3]);
//        dump($userIdArr);
    }


}
