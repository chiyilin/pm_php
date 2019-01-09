<?php
/**
 * Created by Sublime.
 * User: MuZone3
 * Date: 2018/9/30
 * Time: 16:52
 */

namespace app\admin\controller;
header("Content-Type: text/html;charset=utf-8");
use app\admin\controller\Auth;
use app\common\model\UserIdea;
use think\Config;

class Idea extends Auth
{
    public function index(){
        $UserIdea=new UserIdea();
        $data=$UserIdea->back()->paginate();
//        $UserIdea=UserIdea::profile()->select();
//        dump($a->profile->agent_name);die();
        return $this->fetch('',[
            'data'=>$data,
            'page'=>$data->render(),
            'power'=>Config::get('UserIdea')['UserIdea_power']
        ]);
    }
    public function del(){
        $result=UserIdea::destroy(input('param.id'));
        return $msg=$result?'删除成功':'删除失败';
    }
    public function delall(){
        $id=input('param.id/a');
        if(empty($id)) return '请选中后操作！';

        $idArr=implode(',',$id);
        $result=UserIdea::destroy($idArr);
        return $msg=$result?json_encode([200,'删除成功']):json_encode([400,'删除失败']);
    }

}