<?php

namespace app\admin\controller;

use app\common\model\ProdListBetween;
use app\common\model\User as UserModel;
use app\common\model\Product;

use app\common\model\ProdList;
use app\common\model\UserRecord;
use think\Config;
use think\Request;

class Productlist extends Auth
{
    /**
     * 订单首页
     */
    public function index()
    {
        $where = $search = [];
        if (input('param.nick_name')) {
            $res = UserModel::where('nick_name', 'like', '%' . input('param.nick_name') . '%')->column('user_id');
            $where['user_id'] = ['in', $res];
            $search['nick_name'] = input('param.nick_name');
        }
        if (input('param.list_id')) {
            $where['list_id'] = input('param.list_id');
            $search['list_id'] = input('param.list_id');
        }
        if (input('param.order_number')) {
            $where['order_number'] = ['like', '%' . input('param.order_number') . '%'];
            $search['order_number'] = input('param.order_number');
        }
        if (input('param.transaction_id')) {
            $where['transaction_id'] = ['like', '%' . input('param.transaction_id') . '%'];
            $search['transaction_id'] = input('param.transaction_id');
        }
        if (input('param.is_pay')) {
            $where['is_pay'] = input('param.is_pay');
            $search['is_pay'] = input('param.is_pay');
        }
        if (input('param.list_type')) {
            $where['list_type'] = input('param.list_type');
            $search['list_type'] = input('param.list_type');
        }
        $data = ProdList::with([
            'user' => function ($query) {
                $query->field('user_id,nick_name');
            }, 'between' => function ($query) {
                $query->field('product_id,list_id,product_info');
            }])->where($where)->order('list_add_time desc')->paginate($this->basicConfig['paginate'], false, ['query' => input('param.')]);

        return $this->fetch('', [
            'data' => $data,
            'page' => $data->render(),
            'search' => $search,
        ]);
    }

    /**
     * 订单首页
     */
    public function index1()
    {
        $where = $search = [];
        if (input('param.nick_name')) {
            $res = UserModel::where('nick_name', 'like', '%' . input('param.nick_name') . '%')->column('user_id');
            $where['user_id'] = ['in', $res];
            $search['nick_name'] = input('param.nick_name');
        }
        if (input('param.list_id')) {
            $where['list_id'] = input('param.list_id');
            $search['list_id'] = input('param.list_id');
        }
        if (input('param.order_number')) {
            $where['order_number'] = ['like', '%' . input('param.order_number') . '%'];
            $search['order_number'] = input('param.order_number');
        }
        if (input('param.transaction_id')) {
            $where['transaction_id'] = ['like', '%' . input('param.transaction_id') . '%'];
            $search['transaction_id'] = input('param.transaction_id');
        }
        if (input('param.is_pay')) {
            $where['is_pay'] = input('param.is_pay');
            $search['is_pay'] = input('param.is_pay');
        }
        if (input('param.list_type')) {
            $where['list_type'] = input('param.list_type');
            $search['list_type'] = input('param.list_type');
        }
        $data = ProdListBetween::with([
            'user' => function ($query) {
                $query->field('user_id,nick_name');
            }])->where($where)->order('add_time desc')->paginate($this->basicConfig['paginate'], false, ['query' => input('param.')]);
        foreach ($data as $key => $value) {
            $data[$key]['product_info'] = unserialize($value['product_info']);
        }
//        $data = ProdList::with([
//            'user' => function ($query) {
//                $query->field('user_id,nick_name');
//            }, 'between' => function ($query) {
//                $query->field('product_id,list_id,product_info');
//            }])->where($where)->order('list_add_time desc')->paginate($this->basicConfig['paginate'], false, ['query' => input('param.')]);
        $status = Config::get('status');
        return $this->fetch('', [
            'data' => $data,
            'page' => $data->render(),
            'search' => $search,
            'status' => $status
        ]);
    }

    /**
     * 编辑快单单号信息
     */
    public function editSendOut(Request $request)
    {
        $param = $request->param();
        if ($request->isPost()) {
            $data = $param['data'];
            $result = ProdListBetween::where(['between_id' => $data['between_id']])->update(['tracking_number' => $data['tracking_number'], 'is_pay' => 5]);
            return $msg = $result ? json_encode([200, '保存成功！']) : json_encode([400, '保存失败！']);
        } else {
            $listInfo = ProdListBetween::where(['between_id' => $param['id'], 'is_pay' => ['in', '2,3,4']])->limit(1)->find();
            if (empty($listInfo)) {
                $this->error('无法为此订单编辑物流信息！');
            }
            $listInfo['product_info'] = unserialize($listInfo['product_info']);
            $express_info = json_decode($listInfo['product_info']['express_info'], true);
        }
        return $this->fetch(null, ['listInfo' => $listInfo, 'express_info' => $express_info]);
    }

    /**
     * 会员充值列表
     */
    public function recode()
    {
        $where = $search = [];
        if (input('param.nick_name')) {
            $res = UserModel::where('nick_name', 'like', '%' . input('param.nick_name') . '%')->column('user_id');
            $where['user_id'] = ['in', $res];
            $search['nick_name'] = input('param.nick_name');
        }
        if (input('param.list_id')) {
            $where['list_id'] = input('param.list_id');
            $search['list_id'] = input('param.list_id');
        }
        if (input('param.order_number')) {
            $where['order_number'] = ['like', '%' . input('param.order_number') . '%'];
            $search['order_number'] = input('param.order_number');
        }
        if (input('param.transaction_id')) {
            $where['transaction_id'] = ['like', '%' . input('param.transaction_id') . '%'];
            $search['transaction_id'] = input('param.transaction_id');
        }
        if (input('param.is_pay')) {
            $where['is_pay'] = input('param.is_pay');
            $search['is_pay'] = input('param.is_pay');
        }


        $data = UserRecord::with('user,member')->where($where)->order('user_record_add_time desc')->paginate($this->basicConfig['paginate']);

        $fxs = Config::get('miniapp')['fxs'];
//        dump($data->toArray());
        return $this->fetch('', [
            'data' => $data,
            'page' => $data->render(),
            'search' => $search,
            'fxs' => $fxs,
        ]);
    }

    /**
     * 删除订单
     */
    public function del()
    {
        $result = ProdList::destroy(input('param.id'));
        return $msg = $result ? '删除成功' : '删除失败';
    }

    /**
     * 多选删除订单
     */
    public function delall()
    {
        $id = input('param.id/a');
        if (empty($id)) return '请选中后操作！';
        $idArr = implode(',', $id);
        $result = ProdList::destroy($idArr);
        return $msg = $result ? json_encode([200, '删除成功']) : json_encode([400, '删除失败']);
    }

}