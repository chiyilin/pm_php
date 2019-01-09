<?php

namespace app\command;

use app\common\model\User;
use app\common\model\ProdList;

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

}
