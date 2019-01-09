<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/9/18
 * Time: 17:25
 */

namespace app\api\controller;

use think\Controller;
use app\common\model\Server as ServerModel;
use app\common\model\ProdList;
use app\common\model\ServerImg;

class Server extends Controller
{
    /**
     * 用户提交服务信息
     */
    public function add()
    {
        $where = [];
        if (input('param.order_number')) {
            $where['order_number'] = input('param.order_number');
        } else if (input('param.list_id')) {
            $where['list_id'] = input('param.list_id');
        } else {
            $this->result([], 400, '参数错误');
        }
        $ProdList = ProdList::where($where)->find();
        if (!$ProdList) {
            $this->result([], 400, '订单异常');
        }
        $res = ServerModel::create([
            'list_id' => $ProdList['list_id'],
            'product_id' => $ProdList['product_id'],
            'product_class_id' => $ProdList['product_class_id'],
            'user_id' => $ProdList['user_id'],
            'list_type' => $ProdList['list_type'],
            'company' => input('param.company'),
            'name' => input('param.name'),
            'phone' => input('param.phone'),
            'area' => implode(',', input('param.area/a')),
            // 'area'=>json_encode(input('param.area/a')),
            // 'area'=>input('param.area/a'),
            'add_time' => time(),
        ]);
        $this->result($res, 200, 'success');

    }

    /**
     * 用户提交服务上传图片
     */
    public function imgupload()
    {
        $file = request()->file('image');
        $path = 'public/uploads/serverImg';
        $info = $file->move(ROOT_PATH . $path);
        if ($info) {
            $res = ServerImg::create([
                'user_id' => input('param.user_id'),
                'agent_id' => input('param.agent_id'),
                'server_id' => input('param.server_id'),
                'server_img_src' => 'uploads/serverImg' . '/' . $info->getSaveName(),
                'server_img_add_time' => time(),
            ]);
            $this->result($res, 200, 'success');
        } else {
            echo $file->getError();
        }
    }


}