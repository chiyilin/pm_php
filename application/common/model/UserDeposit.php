<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/8/31
 * Time: 16:51
 */

namespace app\common\model;


use think\Model;

class UserDeposit extends Model
{
    public function user()
    {
        return $this->hasOne('user', 'user_id', 'user_id');
    }


}