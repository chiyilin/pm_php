<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/3
 * Time: 16:49
 */

namespace app\common\model;


use think\Model;

class UserGetProd extends Model
{
    public function product()
    {
       return $this->hasOne('Product', 'product_id', 'product_id');
    }
}