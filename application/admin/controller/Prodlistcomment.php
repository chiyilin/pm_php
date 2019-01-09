<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/9/30
 * Time: 13:48
 */

namespace app\admin\controller;
use app\common\model\ProductClass;
use app\common\model\ProductSample;
use think\Config;
use app\common\model\Product as ProductModel;
use app\common\model\Category;
use app\common\model\ProductBanner;
use think\Session;

use app\common\model\ProdListComment as ProdListCommentModel;
use app\common\model\ProdListCommentImg;

class Prodlistcomment extends Auth
{
    /**
     * 评论列表
     */
    public function index(){
        $config=Config::get('admin');
        $where=$search=[];
        if(input('param.list_comment_id')){
            $where['list_comment_id']=input('param.list_comment_id');
            $search['list_comment_id']=input('param.list_comment_id');
        }
        if(input('param.list_comment_content')){
            $where['list_comment_content']=['like','%'.input('param.list_comment_content').'%'];
            $search['list_comment_content']=input('param.list_comment_content');
        }
        $data=ProdListCommentModel::with('prodlistcommentimg,user,product,prodlist')->where($where)->order('list_comment_add_time desc')->paginate($config['paginate']);
        // dump($data);
        
        //查一级分类
        $cateOne=Category::where('category_fid',0)->order('category_group_sort,category_sort')->field('category_id,category_name')->select();
        return $this->fetch('',[
            'data'=>$data,
            'search'=>$search,
            'cateOne'=>$cateOne
        ]);
    }
    /**
     * 评论图片
     */
    public function commentimg(){
        $ProdListCommentImg=ProdListCommentImg::where(['list_comment_id'=>input('param.id')])->select();
        // dump($ProdListCommentImg->toArray());
        $config=Config::get('admin');
        return $this->fetch('',[
                'ProdListCommentImg'=>$ProdListCommentImg,
                'config'=>$config
            ]);
        $ProdListCommentImg=ProdListCommentImg::where(['list_comment_id'=>input('param.id')])->select();
    }
    /**
     * 删除评论
     */
    public function del(){
        $id=input('param.id');
        $imgArr=ProdListCommentImg::where('list_comment_id',$id)->select();
        foreach ($imgArr as $key => $value) {
            $url=ROOT_PATH.$value->list_comment_img_src;
            if(file_exists($url)){
                unlink($url);
                clearstatcache();
            }
        }
        ProdListCommentImg::where('list_comment_id',$id)->delete();
        $result=ProdListCommentModel::destroy($id);
        return $msg=$result?'删除成功':'删除失败';
    }
    /**
     * 多选删除评论
     */
    public function delall(){
        $id=input('param.id/a');
        if(empty($id)) return '请选中后操作！';
        $idArr=implode(',',$id);
        $imgArr=ProdListCommentImg::where('list_comment_id','in',$idArr)->select();
        foreach ($imgArr as $key => $value) {
            $url=ROOT_PATH.$value->list_comment_img_src;
            if(file_exists($url)){
                unlink($url);
                clearstatcache();
            }
        }
        ProdListCommentImg::where('list_comment_id','in',$idArr)->delete();
        $result=ProdListCommentModel::destroy($idArr);
        return $msg=$result?json_encode([200,'删除成功']):json_encode([400,'删除失败']);
    }
    /**
     * 获取二级分类
     */
    public function getTwoCate(){
        $fid=input('param.fid');
        $data=Category::where('category_fid',$fid)->order('category_group_sort,category_fid,category_sort')->field('category_id,category_name')->select();
        $this->result($data,200,'获取二级分类');
    }
    /**
     * 修改评论状态
     */
    public function editstatus(){
        $param=input('param.');
        $ProductModel=new ProductModel();
        $result=$ProductModel->save(
            [
                'product_status'=>$param['value']
            ],[
                'product_id'=>$param['id']
            ]
        );
        return $result?json_encode([200,'修改成功！']):json_encode([400,'修改失败！']);
    }
}