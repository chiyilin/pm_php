<?php
/**
 * Created by Sublime text3.
 * User: MuZone3
 * Date: 2018/9/21
 * Time: 11:17
 */

namespace app\common\model;


use think\Model;

class Product extends Model
{
    public function productBanner()
    {
        return $this->hasMany('ProductBanner', 'product_id', 'product_id');
    }

    public function firstCate()
    {
        return $this->hasOne('Category', 'category_id', 'cate_id_first');
    }

    public function secondCate()
    {
        return $this->hasOne('Category', 'category_id', 'cate_id_second');
    }

    public function thirdCate()
    {
        return $this->hasOne('Category', 'category_id', 'cate_id_third');
    }

    public function userOfferPrice()
    {
        return $this->hasMany('UserOfferPrice', 'product_id', 'product_id');
    }

    public function userCollection()
    {
        return $this->hasMany('UserCollection', 'product_id', 'product_id');
    }

    /**
     * 计算商品数量
     */
    public static function getProdCount($where)
    {
        return $data = Product::where($where)->count();
    }
}