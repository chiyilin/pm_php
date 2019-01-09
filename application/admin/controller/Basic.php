<?php
/**
 * Created by Sublime Text3.
 * User: MuZone
 * Date: 2018/10/24
 * Time: 13:58
 */

namespace app\admin\controller;
header("content-type:text/html;charset=utf-8");


use think\Config;
use think\Controller;
use think\Cookie;


class Basic extends Controller
{
    public $basicConfig;
    public function _initialize()
    {
        parent::_initialize();
        $page=Config::get('adminpage');
        Cookie::set('webname',$page['name']);
        $this->basicConfig=Config::get('admin');
    }

}