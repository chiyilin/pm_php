<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/9/20
 * Time: 12:11
 */

namespace app\admin\controller;

use think\Config;
use app\common\model\UserAddress as UserAddressModel;
use app\common\model\User as UserModel;

class Useraddress extends Auth
{
    /**
     * 用户地址首页
     */
    public function index(){
        $where=$search=[];
        if(input('param.nick_name')){
            $res=UserModel::where('nick_name','like','%'.input('param.nick_name').'%')->column('user_id');
            $where['user_id']=['in',$res];
            $search['nick_name']=input('param.nick_name');
        }
        $UserAddress=UserAddressModel::with('user')->where($where)->paginate($this->basicConfig['paginate']);
//        halt($UserAddress->toArray());
        return $this->fetch('',[
            'data'=>$UserAddress,
            'page'=>$UserAddress->render(),
            'power'=>Config::get('admin')['admin_power'],
            'search'=>$search,
        ]);
    }
}