<?php
/**
 * Created by Sublime Text3.
 * User: Muzone3
 * Date: 2018/10/11
 * Time: 17:17
 */

namespace app\common\model;


use think\Model;

class ProdList extends Model
{
    public function user()
    {
        return $this->hasOne('User', 'user_id', 'user_id');
    }

    public function between()
    {
        return $this->hasMany('ProdListBetween', 'list_id', 'list_id');
    }

    public function productbanner()
    {
        return $this->hasOne('ProductBanner', 'product_id', 'product_id');
    }

    public function product()
    {
        return $this->hasMany('ProdListBetween', 'list_id', 'list_id')->hasMany('Product', 'product_id', 'product_id');
    }
}