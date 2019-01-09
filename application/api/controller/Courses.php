<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/10/11
 * Time: 11:10
 */

namespace app\api\controller;


use app\common\model\Category;
use think\Controller;
use app\common\model\Product;

class Courses extends Controller
{
    /**
     * 课程列表（热门课程、推荐课程、最新课程）
     */
    public function index()
    {
        $where = $sort = [];
        $where['product_status'] = 1;
        $index = input('param.index');
        //热门课程、推荐课程、最新课程
        if ($index == 0) {
            $sort = ['product_subscribe' => 'desc'];
        } else if ($index == 1) {
            $sort = ['product_sort' => 'asc'];
        } else {
            $sort = ['product_time' => 'desc'];
        }
        $productList = Product::with('product_banner')->where($where)->order($sort)->select()->toArray();
        foreach ($productList as $key => $value) {
            $temArr = json_decode($value['product_introduce'], true);
            $temStr = '';
            if (!is_array($temArr)) continue;
            foreach ($temArr as $k => $v) {
                $temStr .= !empty($v['image']) ? ' [图片] ' : $v['text'];
            }
            $productList[$key]['product_introduce'] = $temStr;
        }
        $category = Category::where(['category_fid' => 0])->select()->toArray();
        array_unshift($category, ['category_id' => 0, 'category_name' => '全部']);
        return $this->result(compact('productList', 'category'), 200, '信息获取成功');
    }

    /*
     * 课程列表选项卡切换
     */
    public function product()
    {
        $where = $sort = [];
        $category_id = input('param.category_id');
        $index = input('param.index');
        $where['product_status'] = 1;
        if ($category_id) {
            $where['product_category'] = $category_id;
        }
        //热门课程、推荐课程、最新课程
        if ($index == 0) {
            $sort = ['product_subscribe' => 'desc'];
        } else if ($index == 1) {
            $sort = ['product_sort' => 'asc'];
        } else {
            $sort = ['product_time' => 'desc'];
        }
        $productList = Product::where($where)->order($sort)->select();
        foreach ($productList as $key => $value) {
            $temArr = json_decode($value['product_introduce'], true);
            $temStr = '';
            if (!is_array($temArr)) continue;
            foreach ($temArr as $k => $v) {
                $temStr .= !empty($v['image']) ? ' [图片] ' : $v['text'];
            }
            $productList[$key]['product_introduce'] = $temStr;
        }
        return $this->result(compact('productList'), 200, 'success');
    }

    /*
     * 评价套餐-单节
     */
    public function taocan()
    {
        $taoc_id = input('param.taoc_id') ? input('param.taoc_id') : '';
        $res = Product::where('product_status', '1')->where('taoc_id', $taoc_id)->order('product_time desc')->select();
        $this->result($res, 200, '产品信息获取成功');
    }
}