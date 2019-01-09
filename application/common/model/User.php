<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/9/21
 * Time: 13:28
 */

namespace app\common\model;


use think\Model;

class User extends Model
{
    public function useraddress()
    {
        return $this->hasMany('UserAddress', 'user_id', 'user_id');
    }

}