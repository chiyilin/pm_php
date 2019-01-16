<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/12/22
 * Time: 11:42
 */

namespace app\common\model;


use think\Model;

class UserOfferPrice extends Model
{
    public function User()
    {
        return $this->hasOne('User', 'user_id', 'user_id');
    }

    public function product()
    {
        return $this->hasOne('Product', 'product_id', 'product_id');
    }
}