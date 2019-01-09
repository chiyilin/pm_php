<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/9/28
 * Time: 16:15
 */

namespace app\common\model;


use think\Model;

class ProductBanner extends Model
{
	public function product(){
		return $this->hasOne('Product','product_id','product_id');
	}
}