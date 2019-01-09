<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/8/27
 * Time: 13:11
 */

namespace app\common\model;


use think\Model;

class ProdListComment extends Model
{
	public function user(){
		return $this->hasOne('User','user_id','user_id');
	}
	public function prodlistcommentimg(){
		return $this->hasMany('ProdListCommentImg','list_comment_id','list_comment_id');
	}
	public function product(){
		return $this->hasOne('Product','product_id','product_id');
	}
	public function agent(){
		return $this->hasOne('\app\agent\model\Agent','agent_id','agent_id');
	}
    public function producttaoc(){
        return $this->hasOne('ProductTaoc','taoc_id','taoc_id');
    }
	public function prodlist(){
		return $this->hasOne('ProdList','list_id','list_id');
	}
	
}