<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/12/19
 * Time: 16:42
 */

namespace app\api\controller;


use think\Controller;
use app\common\model\Entrust as EntrustModel;
use think\Image;
use app\common\model\EntrustImage;
use think\Request;

class Entrust extends Controller
{
    /**
     * 创建委托、估价
     */
    public function create(Request $request)
    {
        $param = $request->post();
        $result = EntrustModel::create([
            'entrust_name' => $param['entrust_name'],
            'entrust_phone' => $param['entrust_phone'],
            'user_id' => $param['user_id'],
            'entrust_content' => $param['entrust_content'],
            'entrust_type' => $param['entrust_type'],
            'add_time' => time(),
        ]);
        $this->result($result, 200, 'success');
    }

    /**
     * 上传图片
     */
    public function uploadImage(Request $request)
    {
        $file = $request->file('image');
        $post = $request->post();
        $path = 'uploads/weituo';
        $res = $file->move($path);
        $resImageInfo = $path . '/' . $res->getSaveName();
        $img = Image::open($path . '/' . $res->getSaveName());
        $img->thumb(500, 500)->save($resImageInfo);
        $res = EntrustImage::create([
            'url' => $path . '/' . $res->getSaveName(),
            'entrust_id' => $post['entrust_id'],
            'sort' => $post['sort'],
            'add_time' => time(),
        ]);
        $this->result($res, 200, 'success');
    }
}