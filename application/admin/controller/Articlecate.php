<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/8/27
 * Time: 12:45
 */

namespace app\admin\controller;
use app\common\model\ArticleCate as ArticleCateModel;

class Articlecate extends Auth
{
    public function index(){
        $data=ArticleCateModel::order('cate_sort')->Paginate(20,false,['query'=>request()->param()]);
        return $this->fetch('',[
            'data'=>$data,
        ]);
    }
    //修改分类排序
    public function editsort(){
        $param=input('param.');
        $Category=new ArticleCateModel();
        $result=$Category->save(
            [
                'cate_sort'=>$param['value']
            ],[
                'cate_id'=>$param['id']
            ]
        );
        return $result?json_encode([200,'修改成功！']):json_encode([400,'修改失败！']);
    }
    //修改分类状态
    public function editstatus(){
        $param=input('param.');
        $Category=new ArticleCateModel();
        $result=$Category->save(
            [
                'cate_status'=>$param['value']
            ],[
                'cate_id'=>$param['id']
            ]
        );
        return $result?json_encode([200,'修改成功！']):json_encode([400,'修改失败！']);
    }
    //删除
    public function del(){
        $result=ArticleCateModel::destroy(input('param.id'));
        return $msg=$result?'删除成功':'删除失败';
    }
    //多选删除
    public function delall(){
        $id=input('param.id/a');
        if(empty($id)) return '请选中后操作！';

        $idArr=implode(',',$id);
        $result=ArticleCateModel::destroy($idArr);
        return $msg=$result?json_encode([200,'删除成功']):json_encode([400,'删除失败']);
    }
    //新增分类
    public function add(){
        if(!$this->request->isPost()){
            return json_encode([400,'请求失败']);
        }
        $param=$this->request->param()['data'];
        $countNow=ArticleCateModel::where(['cate_name'=>$param['cate_name']])->count();
        $countNow?$this->error('分类已存在！'):null;
        $category=new ArticleCateModel();
        $res=$category->save([
            'cate_name'=>$param['cate_name'],
            'add_time'=>time(),
        ]);
        return $msg=$res?json_encode([200,'添加成功']):json_encode([400,'添加失败']);
    }
    public function edit(){
        if($this->request->isPost()){
            $param=$this->request->param()['data'];
//            echo $param['category_status'];die();
            $cate=new ArticleCateModel();
            $result=$cate->save([
                'cate_name'=>$param['cate_name'],
                'cate_status'=>!empty($param['cate_status'])?1:2,
                'cate_sort'=>$param['cate_sort'],
            ],[
                'cate_id'=>$param['cate_id'],
            ]);
            return $msg=$result?json_encode([200,'修改成功']):json_encode([400,'修改失败']);
        }
        $data=ArticleCateModel::get(input('param.id'));
        if(!$data){
            return ;
        }
        return $this->fetch('',[
            'data'=>$data,
        ]);
    }

}