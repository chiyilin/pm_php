<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/9/14
 * Time: 17:25
 */

namespace app\api\controller;
use think\Controller;
use app\common\model\ProdList;
use app\common\model\ProdListComment as ProdListCommentModel;
use app\common\model\ProdListCommentImg;

class Prodlistcomment extends Controller
{
    /**
     * 用户评论上传图片
     */
    public function imgupload(){
        $file = request()->file('image');
        $path='public/uploads/productcomment';
        $info = $file->move(ROOT_PATH.$path);
        if($info){
            $res=ProdListCommentImg::create([
                    'list_comment_id'=>input('param.list_comment_id'),
                    'user_id'=>input('param.user_id'),
                    'list_comment_img_src'=>'uploads/productcomment'.'/'.$info->getSaveName(),
                    'list_comment_img_add_time'=>time(),
                ]);
            $this->result($res,200,'success');
        }else{
            echo $file->getError();
        }
    }
    /**
     * 发布评论
     */
    public function addcomment(){
        $res=ProdListCommentModel::create([
                'product_id'=>input('param.product_id')?input('param.product_id'):'0',
                'taoc_id'=>input('param.taoc_id')?input('param.taoc_id'):'0',
                'list_id'=>input('param.list_id'),
                'user_id'=>input('user_id'),
                'list_comment_content'=>input('list_comment_content'),
                'list_comment_add_time'=>time(),
            ]);
        ProdList::where('list_id',input('param.list_id'))->update(['is_pay'=>3]);
        $this->result($res,200,'success');
    }
    
}