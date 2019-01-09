<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/9/25
 * Time: 10:57
 */

namespace app\admin\controller;

use app\admin\model\Admin as AdminModel;
use app\admin\model\Admin;
use think\Config;

class Manage extends Auth
{
    /**
     * 管理员首页
     */
    public function index(){
        $AdminModel=AdminModel::where(['admin_id'=>['neq',40]])->paginate($this->basicConfig['paginate']);
//        dump($AdminModel->toArray());
        return $this->fetch('',[
            'data'=>$AdminModel,
            'page'=>$AdminModel->render(),
            'power'=>Config::get('admin')['admin_power']
        ]);
    }

    /**
     * 修改管理员状态
     */
    public function editstatus(){
        $param=input('param.');
        $AdminModel=new AdminModel();
        $result=$AdminModel->save(
            [
                'admin_is_lock'=>$param['value']
            ],[
                'admin_id'=>$param['id']
            ]
        );
        return $result?json_encode([200,'修改成功！']):json_encode([400,'修改失败！']);
    }
    /**
     * 管理员添加
     */
    public function add(){
        if($this->request->isPost()){
            $param=$this->request->param()['data'];
            $hasName=Admin::where('admin_name',$param['admin_name'])->find();
            if($hasName){
                return json_encode([400,'管理员名称不可重复']);
            }
            $hasPhone=Admin::where('admin_phone',$param['admin_phone'])->find();
            if($hasPhone){
                return json_encode([400,'管理员手机号不可重复']);
            }
            $admin=new Admin($param);
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
     * 管理员修改
     */
    public function edit(){
        if($this->request->isPost()){
            $param=$this->request->param()['data'];
            $hasPhone=Admin::where('admin_phone',$param['admin_phone'])->where('admin_id','neq',$param['admin_id'])->find();
            if($hasPhone){
                return json_encode([400,'管理员手机号不可重复']);
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
     * 删除管理员
     */
    public function del(){
        $result=Admin::destroy(input('param.id'));
        return $msg=$result?'删除成功':'删除失败';
    }
    /**
     * 多选删除管理员
     */
    public function delall(){
        $id=input('param.id/a');
        if(empty($id)) return '请选中后操作！';

        $idArr=implode(',',$id);
        $result=Admin::destroy($idArr);
        return $msg=$result?json_encode([200,'删除成功']):json_encode([400,'删除失败']);
    }
}