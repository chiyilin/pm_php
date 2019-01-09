<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/12/19
 * Time: 16:41
 */

namespace app\common\model;


use think\Model;

class Entrust extends Model
{
    public function image(){
        return $this->hasMany('EntrustImage','entrust_id','entrust_id');
    }
}