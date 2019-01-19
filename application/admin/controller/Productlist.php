<?php

namespace app\admin\controller;

use app\common\Excel;
use app\common\model\ProdListBetween;
use app\common\model\User as UserModel;
use app\common\model\Product;

use app\common\model\ProdList;
use app\common\model\UserRecharge;
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
    public function indexBetween()
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
            $result = ProdListBetween::where(['between_id' => $data['between_id']])->update(['tracking_number' => $data['tracking_number'], 'is_pay' => 4]);
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

    public function printf(Request $request)
    {
        if ($request->isPost()) {
            $param = $request->param();
            $where = [];
//            ?start=&end=&between_id=&user_id=&order_number=&transaction_id=&is_pay=&list_type=
            if (!empty($param['start'])) {
                $where['start'] = strtotime($param['start']);
            }
            if (!empty($param['end'])) {
                $where['end'] = strtotime($param['end']);
            }
            if (!empty($param['between_id'])) {
                $where['between_id'] = $param['between_id'];
            }
            if (!empty($param['user_id'])) {
                $where['user_id'] = $param['user_id'];
            }
            if (!empty($param['order_number'])) {
                $where['order_number'] = ['like', $param['user_id']];
            }
            if (!empty($param['transaction_id'])) {
                $where['transaction_id'] = ['like', $param['transaction_id']];
            }
            if (!empty($param['is_pay'])) {
                $where['is_pay'] = $param['is_pay'];
            }
            if (!empty($param['list_type'])) {
                $where['list_type'] = $param['list_type'];
            }
            $data = ProdListBetween::with('user')->where($where)->select();
            foreach ($data as $key => $value) {
                $data[$key]['product_info'] = unserialize($value['product_info']);
                $data[$key]['on_hand_time'] = $value['on_hand_time'] ? date('Y-m-d H:i:s', $value['on_hand_time']) : null;
                $data[$key]['pay_time'] = $value['pay_time'] ? date('Y-m-d H:i:s', $value['pay_time']) : null;
                $data[$key]['add_time'] = $value['add_time'] ? date('Y-m-d H:i:s', $value['add_time']) : null;
            }
            $this->saveExcel($data);

        }
        $status = Config::get('status');
        return $this->fetch(null, [
            'status' => $status
        ]);
    }

    /**
     * 导出订单表格
     */
    private function saveExcel($data = null)
    {
        $count = count($data);
        $excel = new Excel();
        $ppp = ceil($count / 10000);
        if (!$ppp) {
            return json_encode([400, '暂无订单信息！']);
        }
        $defaultExpress = Config::get('express');
        $status = Config::get('status');
        $pp = range(1, $ppp);
        foreach ($pp as $key => $value) {
            $rs[$key] = $data;
//                  `between_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '订单商品中间表',
//                  `get_id` int(10) DEFAULT NULL COMMENT '得表表主键ID',
//                  `user_id` int(10) NOT NULL,
//                  `list_id` int(10) NOT NULL,
//                  `transaction_id` char(30) DEFAULT NULL,
//                  `order_number` char(30) NOT NULL,
//                  `product_id` int(10) NOT NULL,
//                  `product_info` text NOT NULL COMMENT '商品信息',
//                  `result_money` decimal(10,2) NOT NULL COMMENT '成交价格（不含服务费）',
//                  `server_money` decimal(10,2) NOT NULL COMMENT '服务费',
//                  `total_price` decimal(10,2) NOT NULL COMMENT '应付总价（不含邮费）',
//                  `pay_money` decimal(10,2) NOT NULL COMMENT '单件商品最终实付金额（含邮费）',
//                  `express_id` int(10) DEFAULT NULL COMMENT '快递邮费ID',
//                  `express_money` decimal(10,2) DEFAULT NULL COMMENT '邮费价格',
//                  `is_pay` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1、未支付；2、已支付',
//                  `list_type` tinyint(1) NOT NULL COMMENT '订单类型（1、竞拍订单；2、一口价订单）',
//                  `tracking_number` char(20) DEFAULT NULL COMMENT '物流单号',
//                  `on_hand_time` int(10) DEFAULT NULL COMMENT '到手时间',
//                  `pay_time` int(10) DEFAULT NULL,
//                  `add_time` int(10) NOT NULL,
            $str[$key] = "订单ID,订单号,支付单号,用户,商品,成交价格（不含服务费）,服务费,应付总价（不含邮费）,邮费价格,最终实付金额（含邮费）,物流信息,物流单号,订单类型,订单状态,下单时间,付款时间,确认收货时间";
            $excelTh[$key] = explode(',', $str[$key]);
            foreach ($rs[$key] as $k => $v) {
                $expressInfo = json_decode($v['product_info']['express_info'], true);
                $exl[$key][] = array(
                    $v['between_id'] ? $v['between_id'] : null,
                    $v['order_number'] ? '"' . $v['order_number'] . '"' : null,
                    $v['transaction_id'] ? '"' . $v['transaction_id'] . '"' : null,
                    $v['user']['nick_name'] ? $v['user']['nick_name'] : null,
                    $v['product_info']['product_name'] ? $v['product_info']['product_name'] : null,
                    $v['result_money'],
                    $v['server_money'],
                    $v['total_price'],
                    $v['express_money'],
                    $v['pay_money'],
                    !empty($expressInfo) ? $expressInfo[$v['express_id']]['name'] : $defaultExpress[$v['express_id']]['name'],
                    $v['tracking_number'] ? '"' . $v['tracking_number'] . '"' : null,
                    $status['list_type'][$v['list_type']]['msg'],
                    $status['is_pay'][$v['is_pay']]['msg'],
                    $v['add_time'],
                    $v['pay_time'],
                    $v['on_hand_time']
                );
            }
            $excel->exportToExcel('订单信息' . time() . $value . '.csv', $excelTh[$key], $exl[$key]);
        }
        exit();
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


        $data = UserRecharge::with('user,member')->where($where)->order('user_record_add_time desc')->paginate($this->basicConfig['paginate']);

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