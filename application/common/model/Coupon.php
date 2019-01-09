<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/2
 * Time: 10:21
 */

namespace app\common\model;


use think\Model;

class Coupon extends Model
{
    public function user()
    {
        return $this->hasOne('User', 'user_id', 'user_id');
    }
}