<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/8/24
 * Time: 13:45
 */

namespace app\admin\controller;
header("content-type:text/html;charset=utf-8");
use think\Session;

class Auth extends Basic
{
    public function _initialize()
    {
        parent::_initialize();
        if(!Session::get('admin_id')){
           $this->success('请先登陆','login/login');
        }
    }

}