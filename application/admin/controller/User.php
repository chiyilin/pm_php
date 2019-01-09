<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/9/20
 * Time: 12:11
 */

namespace app\admin\controller;

use app\common\model\User as UserModel;
use think\Config;

class User extends Auth
{
    /**
     * 用户首页
     */
    public function index(){
        $where=$search=[];
        if(input('param.user_id')){
            $where['user_id']=input('param.user_id');
            $search['user_id']=input('param.user_id');
        }
        if(input('param.nick_name')){
            $where['nick_name']=['like','%'.input('param.nick_name').'%'];
            $search['nick_name']=input('param.nick_name');
        }
        if(input('param.user_mobile')){
            $where['user_mobile']=['like','%'.input('param.user_mobile').'%'];
            $search['user_mobile']=input('param.user_mobile');
        }
        if(input('param.user_is_lock')){
            $where['user_is_lock']=['like','%'.input('param.user_is_lock').'%'];
            $search['user_is_lock']=input('param.user_is_lock');
        }
        $UserModel=UserModel::where($where)->paginate($this->basicConfig['paginate'],false,['query'=>request()->param()]);
        return $this->fetch('',[
            'data'=>$UserModel,
            'page'=>$UserModel->render(),
            'power'=>Config::get('admin')['admin_power'],
            'search'=>$search,
        ]);
    }

    /**
     * 修改用户状态
     */
    public function editstatus(){
        $param=input('param.');
        $UserModel=new UserModel();
        $result=$UserModel->save(
            [
                'user_is_lock'=>$param['value']
            ],[
                'user_id'=>$param['id']
            ]
        );
        return $result?json_encode([200,'修改成功！']):json_encode([400,'修改失败！']);
    }
    /**
     * 用户添加
     */
    public function add(){
        if($this->request->isPost()){
            $param=$this->request->param()['data'];
            $hasName=UserModel::where('admin_name',$param['admin_name'])->find();
            if($hasName){
                return json_encode([400,'用户名称不可重复']);
            }
            $hasPhone=UserModel::where('admin_phone',$param['admin_phone'])->find();
            if($hasPhone){
                return json_encode([400,'用户手机号不可重复']);
            }
            $admin=new UserModel($param);
            $admin->data([
                'admin_name'=>$param['admin_name'],
                'admin_phone'=>$param['admin_phone'],
                'admin_power'=>$param['admin_power'],
                'admin_pwd'=>md5($param['pass']),
                'admin_add_time'=>time(),
            ]);
            return $msg=$admin->save()?json_encode([200,'添加成功']):json_encode([400,'添加失败']);
        }
        return $this->fetch();
    }
    /**
     * 用户修改
     */
    public function edit(){
        if($this->request->isPost()){
            $param=$this->request->param()['data'];
            $hasPhone=UserModel::where('admin_phone',$param['admin_phone'])->where('admin_id','neq',$param['admin_id'])->find();
            if($hasPhone){
                return json_encode([400,'用户手机号不可重复']);
            }
            $admin=new Admin();
            $result=$admin->save([
                'admin_name'=>$param['admin_name'],
                'admin_phone'=>$param['admin_phone'],
                'admin_power'=>$param['admin_power'],
                'admin_pwd'=>md5($param['pass']),
            ],[
                'admin_id'=>$param['admin_id']
            ]);
            return $msg=$result?json_encode([200,'修改成功']):json_encode([400,'修改失败']);
        }
        $data=Admin::get(input('param.id'));
//        dump($data);
        return $this->fetch('',[
            'data'=>$data
        ]);
    }
    /**
     * 删除用户
     */
    public function del(){
        $result=UserModel::destroy(input('param.id'));
        return $msg=$result?'删除成功':'删除失败';
    }
    /**
     * 多选删除用户
     */
    public function delall(){
        $id=input('param.id/a');
        if(empty($id)) return '请选中后操作！';

        $idArr=implode(',',$id);
        $result=UserModel::destroy($idArr);
        return $msg=$result?json_encode([200,'删除成功']):json_encode([400,'删除失败']);
    }
}