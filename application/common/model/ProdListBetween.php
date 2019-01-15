<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/4
 * Time: 14:06
 */

namespace app\common\model;


use think\Model;

class ProdListBetween extends Model
{
    public function product()
    {
        return $this->hasOne('Product', 'product_id', 'product_id');
    }

    public function user()
    {
        return $this->hasOne('User', 'user_id', 'user_id');
    }

}