<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/10/30
 * Time: 14:05
 */

namespace app\admin\controller;

use app\common\model\User as UserModel;
use think\Config;
use app\agent\model\Agent;
use app\common\model\UserRecharge;

class Userrecharge extends Auth
{
    /**
     * 用户充值首页
     */
    public function index(){
//        user_id=&nick_name=&user_mobile=&staff_random=&agent_id=&member=&user_is_lock=
        $where=$search=[];
        if(input('param.user_id')){
            $where['user_id']=input('param.user_id');
            $search['user_id']=input('param.user_id');
        }
        if(input('param.user_record_id')){
            $where['user_record_id']=input('param.user_record_id');
            $search['user_record_id']=input('param.user_record_id');
        }
        
        if(input('param.agent_id')||input('param.agent_id')==0){
            $where['agent_id']=['like','%'.input('param.agent_id').'%'];
            $search['agent_id']=input('param.agent_id');
        }
        if(input('param.order_number')){
            $where['order_number']=['like','%'.input('param.order_number').'%'];
            $search['order_number']=input('param.order_number');
        }
        if(input('param.transaction_id')){
            $where['transaction_id']=['like','%'.input('param.transaction_id').'%'];
            $search['transaction_id']=input('param.transaction_id');
        }
        if(input('param.is_pay')){
            $where['is_pay']=input('param.is_pay');
            $search['is_pay']=input('param.is_pay');
        }
        // CREATE TABLE `wyq_user_record` (
        //   `user_record_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '会员充值记录ID',
        //   `order_number` char(20) NOT NULL COMMENT '订单号',
        //   `transaction_id` char(28) NOT NULL COMMENT '微信支付单号',
        //   `agent_id` int(10) NOT NULL COMMENT '代理商ID',
        //   `user_id` int(10) NOT NULL COMMENT '用户ID',
        //   `member_pay_money` decimal(10,2) NOT NULL COMMENT '实付金额',
        //   `is_pay` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否支付(1、未支付；2、已经支付）',
        //   `service_name` varchar(20) NOT NULL COMMENT '服务名称',
        //   `begin_time` int(10) NOT NULL COMMENT '生效时间',
        //   `end_time` int(10) NOT NULL COMMENT '到期时间',
        //   `service_time` int(10) NOT NULL COMMENT '服务时间（月）',
        //   `user_record_add_time` int(10) NOT NULL COMMENT '操作时间',
        //   PRIMARY KEY (`user_record_id`)
        // ) ENGINE=MyISAM AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;
        $UserRecord=UserRecharge::with('user,agent')->where($where)->order('user_record_add_time desc')->paginate($this->basicConfig['paginate']);
        $agentArr=Agent::field('agent_id,agent_name')->select()->toArray();
        // dump($UserRecharge);
        return $this->fetch('',[
            'data'=>$UserRecord,
            'page'=>$UserRecord->render(),
            'search'=>$search,
            'agentArr'=>$agentArr,
            // 'layer'=>$this->basicConfig['layer_level']
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
        $result=UserRecharge::destroy(input('param.id'));
        return $msg=$result?'删除成功':'删除失败';
    }
    /**
     * 多选删除用户
     */
    public function delall(){
        $id=input('param.id/a');
        if(empty($id)) return '请选中后操作！';

        $idArr=implode(',',$id);
        $result=UserRecharge::destroy($idArr);
        return $msg=$result?json_encode([200,'删除成功']):json_encode([400,'删除失败']);
    }
}