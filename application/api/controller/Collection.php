<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/12/15
 * Time: 10:27
 */

namespace app\api\controller;


use think\Controller;
use app\common\model\Category;
use app\common\model\Collection as CollectionModel;
use app\common\model\Product;
use think\Request;

class Collection extends Controller
{
    /**
     * @param Request $request
     * 专场列表
     */
    public function getData(Request $request)
    {
        $param = $request->param();

        $where = [];
        $nowtime = time();
        $where['collection_status'] = 1;
        if ($param['category_id']) {
            $where['category_id'] = $param['category_id'];
        }
        if ($param['current_tab'] == 0) {
            $where['collection_start_time'] = ['<=', $nowtime];
            $where['collection_end_time'] = ['>=', $nowtime];
        } elseif ($param['current_tab'] == 1) {
            $where['collection_start_time'] = ['>', $nowtime];
        } else {
            $where['collection_end_time'] = ['<', $nowtime];
        }
//        dump($where);
        $data = CollectionModel::where($where)->order(['collection_sort' => 'desc'])->select();
        foreach ($data as $key => $value) {
            $data[$key]['collection_start_time'] = date('Y.m.d', $value['collection_start_time']);
            $data[$key]['collection_end_time'] = date('Y.m.d', $value['collection_end_time']);
        }
//        halt($data->toArray());
        $this->result(compact('data'), 200, 'success');
    }

    /*
     * 专场详情
     */
    public function details(Request $request)
    {
        $param = $request->param();
        $collInfo = CollectionModel::limit(1)->find($param['id']);
        $data = [
            'collInfo' => $collInfo
        ];
        $this->result($data, 200, 'success');
    }

    /**
     * 专场下的商品
     */
    public function detailsProd(Request $request)
    {
        $param = $request->param();
        $where = [];
        if ($param['currentTab'] == 1) {
            $where['product_collection_share'] = 2;
        }
        $where['collection_id'] = $param['id'];
        $data = Product::where($where)->order(['product_time' => 'desc'])->field('product_type,product_start_time,product_end_time,product_id,product_name,product_cover,product_money')->select();
        foreach ($data as $key => $value) {
            $data[$key]['product_start_time'] = date('Y-m-d H:i', $value['product_start_time']);
            $data[$key]['product_end_time'] = date('Y-m-d H:i', $value['product_end_time']);
        }
        $this->result($data, 200, 'success');
    }
}