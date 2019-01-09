<?php

/**

 * Created by PhpStorm.

 * User: Y_Lin

 * Date: 2018/8/24

 * Time: 13:57

 */



namespace app\admin\controller;

use app\admin\model\Admin;

use think\Session;
use think\Config;
use think\Cookie;




class Login extends Basic

{

    public function login(){
        $requset=$this->request;
        $page=Config::get('adminpage');
        Cookie::set('webname',$page['name']);
        if(!$requset->isPost()){

            return $this->fetch();

        }

        $param=$this->request->param()['data'];

        $admin=Admin::where(['admin_name|admin_phone'=>$param['admin_name'],'admin_pwd'=>md5($param['admin_pwd'])])->find();

        if($admin['admin_is_lock']==2){

            return $this->result([],400,'账号已锁定，请联系管理员');

        }

        if(!empty($admin)){

            Session::set('admin_id',$admin['admin_id']);

            Session::set('admin_name',$admin['admin_name']);

            Session::set('admin_power',$admin['admin_power']);

            $admin->admin_last_login_time=time();

            $admin->admin_last_login_ip=$_SERVER['REMOTE_ADDR'];

            $admin->save();

            return $this->result([],200,'登陆成功');

        }else{

            return $this->result([],400,'请核对用户名密码');

        }

    }

    public function logout(){

        Session::delete('admin_id');

        Session::delete('admin_name');

        Session::delete('admin_power');

        $this->success('退出成功！','login/login');

    }

    /**
     * 管理员修改
     */
    public function editpwd(){
        if($this->request->isPost()){
            $param=$this->request->param()['data'];
            $oldInfo=Admin::where('admin_id',Session::get('admin_id'))->find();
            if($oldInfo['admin_pwd']!=md5($param['pass'])){
                return json_encode([400,'密码错误！']);
            }
            $admin=new Admin();
            $result=$admin->save([
                'admin_pwd'=>md5($param['newpass']),
            ],[
                'admin_id'=>Session::get('admin_id')
            ]);
            return $msg=$result?json_encode([200,'修改成功']):json_encode([400,'修改失败']);
        }
        $data=Admin::get(Session::get('admin_id'));
//        dump($data);
        return $this->fetch('',[
            'data'=>$data
        ]);
    }

}