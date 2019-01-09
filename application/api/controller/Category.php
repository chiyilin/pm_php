<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/10/22
 * Time: 15:10
 */

namespace app\api\controller;

use app\common\model\Category as CategoryModel;


use app\common\model\Product;
use app\common\model\ProductTaoc;
use think\Config;
use think\Controller;
use app\common\model\Config as ConfigModel;
use think\Request;

class Category extends Controller
{
    /*
     * 获得分类信息
     */
    public function index()
    {
        $oneCate = CategoryModel::where(['category_fid' => 0, 'category_status' => 1])->order('category_sort desc,category_time desc')->select()->toArray();
        foreach ($oneCate as $key => $value) {
            $data[] = $value;
            $oneCate[$key]['_child'] = CategoryModel::where(['category_fid' => $value['category_id'], 'category_status' => 1])->order('category_sort desc,category_time desc')->select()->toArray();
            if (!empty($oneCate[$key]['_child'])) {
                foreach ($oneCate[$key]['_child'] as $k => $v) {
                    $data[] = $v;
                    $oneCate[$key]['_child'][$k]['_child'] = CategoryModel::where(['category_fid' => $v['category_id'], 'category_status' => 1])->order('category_sort desc,category_time desc')->select()->toArray();
                    foreach ($oneCate[$key]['_child'][$k]['_child'] as $kk => $vv) {
                        $data[] = $vv;
                    }
                }
            }
        }
        $this->result(['cate' => $oneCate], 200, 'success');
    }

    /**
     * 查找一级分类
     */
    public function oneCate()
    {
        $cate = CategoryModel::where(['category_fid' => 0])->field('category_id,category_name')->order(['category_sort' => 'desc'])->select()->toArray();
        array_unshift($cate, ['category_id' => 0, 'category_name' => '全部']);
        $this->result($cate, 200, 'success');
    }

    /**
     * @param Request $request
     * 筛选条件查询
     */
    public function serachData(Request $request)
    {
        $param = $request->param();
        $config = Config::get('config');
        $prodFace = $config['face'];
        $cateInfo = CategoryModel::where([
            'category_fid' => $param['category_id'],
            'category_status' => 1
        ])->order([
            'category_group_sort' => 'desc',
            'category_sort' => 'desc'
        ])->field('category_id,category_name,category_level')->select()->toArray();
        if ($cateInfo) {
            $cateIdArr = array_column($cateInfo, 'category_id');
            if ($cateInfo[0]['category_level'] == 3) {
                array_push($cateIdArr, $param['category_id']);
            }
            $cateInfo = CategoryModel::where([
                'category_fid' => ['in', $cateIdArr],
                'category_status' => 1
            ])->order([
                'category_group_sort' => 'desc',
                'category_sort' => 'desc'
            ])->field('category_id,category_name')->select()->toArray();
        }
        $data = [
            //商品品相
            'prodFace' => $prodFace,
            //排序
            'orderData' => [
                1 => '默认排序',
                2 => '价格高的',
                3 => '价格低的',
            ],
            //分类信息
            'cateInfo' => $cateInfo,
        ];
        $this->result($data, 200, 'success');
    }

    /**
     * 查找某分类下的商品
     */
    public function cateProdInfo(Request $request)
    {
        $param = $request->param();
        $where = $order = [];
        $where['product_status'] = 1;
        if (!empty($param['currentTab'])) {
            //['竞价', '预览', '一口价', '成交'];
            $time = time();
            switch ($param['currentTab']) {
                case 1:
                    $where['product_type'] = 1;
                    $where['product_start_time'] = ['<=', $time];
                    $where['product_end_time'] = ['>=', $time];
                    break;
                case 2:
                    $where['product_type'] = 1;
                    $where['product_start_time'] = ['>=', $time];
                    $where['product_end_time'] = ['>=', $time];
                    break;
                case 3:
                    $where['product_type'] = 2;
                    break;
                case 4:
                    $where['product_type'] = 1;
                    $where['product_end_time'] = ['<=', $time];
                    break;
            }
        }
        if (!empty($param['category_id'])) {
            $where['cate_id_first|cate_id_second|cate_id_third'] = $param['category_id'];
        }
        if (!empty($param['currentCate'])) {
            $where['cate_id_first|cate_id_second|cate_id_third'] = ['in', $param['currentCate']];
        }
        if (!empty($param['currentFace'])) {
            $where['product_face'] = ['in', $param['currentFace']];
        }
        if (!empty($param['searchKey'])) {
            $where['product_name'] = ['like', '%' . $param['searchKey'] . '%'];
        }
        if (empty($param['currentSort']) || $param['currentSort'] == 1) {
            $order['product_sort'] = 'desc';
            $order['product_time'] = 'desc';
            $order['product_share_index'] = 'desc';
        } elseif ($param['currentSort'] == 2) {
            $order['product_money'] = 'desc';
        } elseif ($param['currentSort'] == 3) {
            $order['product_money'] = 'asc';
        }
        $data = Product::where($where)->order($order)->field('product_id,product_money,product_cover,product_start_time,product_end_time,product_name,product_type')->select();
        foreach ($data as $key => $value) {
            $data[$key]['product_start_time'] = date('Y-m-d H:i', $value['product_start_time']);
            $data[$key]['product_end_time'] = date('Y-m-d H:i', $value['product_end_time']);
        }
        $this->result($data, 200, 'success');
    }

    /**
     * @param Request $request
     * 分类商品首页展示各类型的商品数量
     */
    public function countProd(Request $request)
    {
        $param = $request->param();
        $where = [];
        $where['product_status'] = 1;
        $idArr = !empty($param['currentCate']) ? $param['currentCate'] : [$param['category_id']];
        $where['cate_id_first|cate_id_second|cate_id_third'] = ['in', $idArr];
        if (!empty($param['currentFace'])) {
            $where['product_face'] = ['in', $param['currentFace']];
        }
        if (!empty($param['searchKey'])) {
            $where['product_name'] = ['like', '%' . $param['searchKey'] . '%'];
        }
        for ($i = 1; $i <= 4; $i++) {
            $time = time();
            switch ($i) {
                case 1:
                    $where['product_type'] = 1;
                    $where['product_start_time'] = ['<=', $time];
                    $where['product_end_time'] = ['>=', $time];
                    $data[$i] = Product::getProdCount($where);
                    break;
                case 2:
                    $where['product_type'] = 1;
                    $where['product_start_time'] = ['>=', $time];
                    $where['product_end_time'] = ['>=', $time];
                    $data[$i] = Product::getProdCount($where);
                    break;
                case 3:
                    $where['product_type'] = 2;
                    $data[$i] = Product::getProdCount($where);
                    break;
                case 4:
                    $where['product_type'] = 1;
                    $where['product_end_time'] = ['<=', $time];
                    $data[$i] = Product::getProdCount($where);
                    break;
            }
            unset($where['product_type'], $where['product_start_time'], $where['product_end_time']);
        }
        $this->result($data, 200, 'success');
    }


    /*
     * 课程-章节展示
     */
    public function product()
    {
        $where = $wheres = [];
        if (input('param.category_id')) {
            $where['product_categorys'] = input('param.category_id');
        }
        $res = Product::with('producttaoc,productbanner')->where($where)->order('product_sort')->select()->toArray();
        $ids = array_column($res, 'taoc_id');
        $taoc = ProductTaoc::with('producttaocbanner')->where($wheres)->where('taoc_id', 'in', $ids)->group('taoc_name')->distinct(true)->order('sort')->select()->toArray();
        foreach ($taoc as $keys => $values) {
            $num = Product::where('taoc_id', $values['taoc_id'])->select();
            $money = Product::where('taoc_id', $values['taoc_id'])->group('taoc_id')->sum('product_money');
            $taoc[$keys]['num'] = count($num);
            $taoc[$keys]['product_money'] = $money;
        }
        $product = Product::with('producttaoc,productbanner')->where($where)->where('taoc_id', 'null')->order('product_sort')->select()->toArray();
        $data = array_merge($taoc, $product);
//        halt($data);
        foreach ($data as $key => $value) {
            if (!empty($value['product_introduce'])) {
                $temArr = json_decode($value['product_introduce'], true);
                $temStr = '';
                if (!is_array($temArr)) continue;
                foreach ($temArr as $k => $v) {
                    $temStr .= !empty($v['image']) ? ' [图片] ' : $v['text'];
                }
                $data[$key]['product_introduce'] = $temStr;
            } elseif ($value['taoc_content']) {
                $temArr = json_decode($value['taoc_content'], true);
                $temStr = '';
                if (!is_array($temArr)) continue;
                foreach ($temArr as $k => $v) {
                    $temStr .= !empty($v['image']) ? ' [图片] ' : $v['text'];
                }
                $data[$key]['taoc_content'] = $temStr;
            }
        }
        $config = ConfigModel::find();
        $this->result(compact('data', 'config'), 200, '已获取产品信息');
    }

    /*
     * 课程-章节排序展示
     */
    public function search()
    {
        // dump(input('param.'));
        $where = $wheres = [];
        if (input('param.content')) {
            $where['product_name'] = ['like', '%' . input('param.content') . '%'];
            $wheres['taoc_name'] = ['like', '%' . input('param.content') . '%'];
        }
        $ids = Product::where(['product_categorys' => input('param.category_id')])->column('taoc_id');
        $taoc = ProductTaoc::with('producttaocbanner')->where($wheres)->where('taoc_id', 'in', $ids)->select();

        foreach ($taoc as $keys => $values) {
            //计算 套餐 内节数
            $num = Product::where('taoc_id', $values['taoc_id'])->select();
            $taoc[$keys]['num'] = count($num);
            //计算 套餐 价格(套餐内节价格相加)
            $money = Product::where('taoc_id', $values['taoc_id'])->group('taoc_id')->sum('product_money');
            $taoc[$keys]['product_money'] = $money;
            //计算 套餐 人气(同上)
            $subscribe = Product::where('taoc_id', $values['taoc_id'])->group('taoc_id')->sum('product_subscribe');
            $taoc[$keys]['product_subscribe'] = $subscribe;
            //重新定义 套餐 排序字段与 单节 排序字段相同
            $taoc[$keys]['product_sort'] = $taoc[$keys]['sort'];
        }
        $taoc = $taoc->toArray();             //将 套餐 对象转为数组
        $product = Product::with('productbanner')->where($where)->where('taoc_id', 'null')->where('product_categorys', input('param.category_id'))->select();
        $product = $product->toArray();       //将 无套餐的节 对象转为数组
        $data = array_merge($taoc, $product);  //将 套餐数组 与 无套餐的节数组 合并为一个数组
        // dump($data[0]['product_money']);die();
//        halt($data);
        foreach ($data as $key => $value) {
            if (!empty($value['product_introduce'])) {
                $temArr = json_decode($value['product_introduce'], true);
                $temStr = '';
                if (!is_array($temArr)) continue;
                foreach ($temArr as $k => $v) {
                    $temStr .= !empty($v['image']) ? ' [图片] ' : $v['text'];
                }
                $data[$key]['product_introduce'] = $temStr;
            } elseif ($value['taoc_content']) {
                $temArr = json_decode($value['taoc_content'], true);
                $temStr = '';
                if (!is_array($temArr)) continue;
                foreach ($temArr as $k => $v) {
                    $temStr .= !empty($v['image']) ? ' [图片] ' : $v['text'];
                }
                $data[$key]['taoc_content'] = $temStr;
            }
            $product_sort[] = $value["product_sort"];             //推荐排序-准备
            $product_money[] = $value['product_money'];           //价格排序-准备
            $product_subscribe[] = $value['product_subscribe'];    //人气排序-准备

        }

//        foreach ($data as $kk => $value) {
//            $temArr = json_decode($value['product_introduce'], true);
//            $temStr = '';
//            if (!is_array($temArr)) continue;
//            foreach ($temArr as $k => $v) {
//                $temStr .= !empty($v['image']) ? ' [图片] ' : $v['text'];
//            }
//            $data[$kk]['product_introduce'] = $temStr;
//
//            $product_sort[] = $value["product_sort"];             //推荐排序-准备
//            $product_money[] = $value['product_money'];           //价格排序-准备
//            $product_subscribe[] = $value['product_subscribe'];    //人气排序-准备
//        }


        // dump($product_sort);die();
        //推荐排序
        if (input('param.tuijianStatus')) {
            if (input('param.tuijianStatus') == 2) {
                array_multisort($product_sort, SORT_ASC, $data);
            } else {
            }
        }
        //价格排序
        if (input('param.jiageStatus')) {
            if (input('param.jiageStatus') == 2) {
                array_multisort($product_money, SORT_DESC, $data);
            } else if (input('param.jiageStatus') == 3) {
                array_multisort($product_money, SORT_ASC, $data);
            } else {
            }
        }
        //人气排序
        if (input('param.renqiStatus')) {
            if (input('param.renqiStatus') == 2) {
                array_multisort($product_subscribe, SORT_DESC, $data);
            } else if (input('param.renqiStatus') == 3) {
                array_multisort($product_subscribe, SORT_ASC, $data);
            } else {
            }
        }
        $config = ConfigModel::find();
        $this->result(compact('data', 'config'), 200, '已获取产品信息');
    }
}