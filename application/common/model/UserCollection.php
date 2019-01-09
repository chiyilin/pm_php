<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/10/17
 * Time: 16:29
 */

namespace app\common\model;


use think\Model;

class UserCollection extends Model
{
	public function product(){
		return $this->hasOne('Product','product_id','product_id');
	}
	public function user(){
		return $this->hasOne('User','user_id','user_id');
	}
}