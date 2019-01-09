<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/8/31
 * Time: 16:51
 */

namespace app\common\model;


use think\Model;

class UserIdea extends Model
{
    public function agent()
    {
        return $this->hasOne('app\agent\model\Agent','agent_id','agent_id');
    }
    public function back(){
        $theme = self::with('agent');
        return $theme;
    }


}