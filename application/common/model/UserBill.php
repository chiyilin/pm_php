<?php

namespace app\common\model;


use think\Model;

class UserBill extends Model
{

    public function user()
    {
        return $this->hasOne('User', 'user_id', 'user_id');
    }
    public function product()
    {
        return $this->hasOne('Product', 'product_id', 'product_id');
    }
    public function taocan()
    {
        return $this->hasOne('ProductTaoc', 'taoc_id', 'taoc_id');
    }
    public function jfproduct()
    {
        return $this->hasOne('Jfproduct', 'jfproduct_id', 'jfproduct_id');
    }
    public function baokao()
    {
        return $this->hasOne('Baokao', 'baokao_id', 'baokao_id');
    }
    public function deposit()
    {
        return $this->hasOne('UserDeposit', 'deposit_id', 'deposit_id');
    }
}