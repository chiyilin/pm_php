<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/10/16
 * Time: 10:36
 */

namespace app\common\model;


use think\Model;

class UserAddress extends Model
{
	public function user(){
		return $this->hasOne('User','user_id','user_id');
	}

}