<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/9/11
 * Time: 12:11
 */

namespace app\common\model;


use think\Model;

class UserRecharge extends Model
{
	public function user(){
		return $this->hasOne('User','user_id','user_id');
	}
	public function member(){
		return $this->hasOne('MemberPrice','id','member_price_id');
	}

}