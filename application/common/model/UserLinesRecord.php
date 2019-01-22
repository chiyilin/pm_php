<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/19
 * Time: 10:20
 */

namespace app\common\model;


use think\Model;

class UserLinesRecord extends Model
{
    public function user()
    {
        return $this->hasOne('user', 'user_id', 'user_id');
    }

}