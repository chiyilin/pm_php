<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/22
 * Time: 14:10
 */

namespace app\admin\controller;


use think\Request;

class Chat extends Auth
{
    public function room(Request $request)
    {
        return $this->fetch(null);
    }
}