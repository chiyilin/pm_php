<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/9/29
 * Time: 11:36
 */

namespace app\admin\controller;

use think\Config;
use think\Image;
use app\common\model\Product as ProductModel;
use app\common\model\Category;
use app\common\model\ProductBanner;
use app\common\model\Collection;
use think\Request;

class Product extends Auth
{

    private $product_type;

    public function _initialize()
    {
        parent::_initialize();
        $this->product_type = input('param.product_type');
    }

    /**
     * 产品列表
     */
    public function index()
    {
        $config = Config::get('admin');
        $where = $search = [];
        $where['product_type'] = $this->product_type;
        if (input('param.id')) {
            $where['product_id'] = input('param.id');
            $search['id'] = input('param.id');
        }
        if (input('param.value')) {
            $where['product_name'] = ['like', '%' . input('param.value') . '%'];
            $search['value'] = input('param.value');
        }
        if (input('param.product_level')) {
            $where['product_level'] = ['like', '%' . input('param.product_level') . '%'];
            $search['product_level'] = input('param.product_level');
        }
        if (input('param.product_status')) {
            $where['product_status'] = input('param.product_status');
            $search['product_status'] = input('param.product_status');
        }
        if (input('param.taoc_id')) {
            $where['taoc_id'] = input('param.taoc_id');
            $search['taoc_id'] = input('param.taoc_id');
        }
        if (input('param.teacher_id')) {
            $where['teacher_id'] = input('param.teacher_id');
            $search['teacher_id'] = input('param.teacher_id');
        }
        $data = ProductModel::with('category')->where($where)->order('product_sort,product_time')->paginate($config['paginate']);
        for ($i = 0; $i < count($data); $i++) {
            $data[$i]['cate_id_first'] = Category::where('category_id', $data[$i]['cate_id_first'])->field('category_name')->find();
            $data[$i]['cate_id_second'] = Category::where('category_id', $data[$i]['cate_id_second'])->field('category_name')->find();
        }
        $product_category = Category::where('category_fid', 0)->order('category_group_sort,category_sort')->field('category_id,category_name')->select();
        $product_categorys = Category::where('category_fid != 0')->order('category_group_sort,category_sort')->field('category_id,category_name')->select();
        $collection = Collection::where([])->select();
        return $this->fetch('', [
            'data' => $data,
            'search' => $search,
            'product_category' => $product_category,
            'product_categorys' => $product_categorys,
            'collection' => $collection,
            'type' => $this->product_type
        ]);
    }

    /**
     *保存商品邮费信息
     */
    public function express(Request $request)
    {
        $param = $request->param();
        $basicExpress = Config::get('express');
        if ($request->isPost()) {
            $param = $param['data'];
            $data = [];
            foreach ($basicExpress as $key => $value) {
                $data[$key]['money'] = $param['express_money' . $key];
                $data[$key]['name'] = $value['name'];
                $data[$key]['description'] = $value['description'];
                $data[$key]['current'] = !empty($param['current' . $key])?true:null;
            }
            $res = ProductModel::where(['product_id' => $param['id']])->update(['express_info' => json_encode($data)]);
            return $res ? json_encode([200, '保存成功！']) : json_encode([400, '保存失败！']);
        }
        $expressDb = ProductModel::where(['product_id' => $param['id']])->limit(1)->field('express_info')->value('express_info');
//        dump(json_decode($expressDb, true));
        $express = !empty($expressDb) ? json_decode($expressDb, true) : $basicExpress;
        return $this->fetch(null, [
            'express' => $express,
            'id' => $param['id'],
        ]);
    }

    /**
     * 产品添加
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $param = $this->request->param()['data'];
            $detailsArr = $this->request->param()['details'];
            $productData = [
                'product_name' => $param['product_name'],
                'cate_id_third' => $param['cate_id_third'],
                'cate_id_second' => $param['cate_id_second'],
                'cate_id_first' => $param['cate_id_first'],
                'cover_introduce' => $param['cover_introduce'],
                'product_introduce' => htmlspecialchars_decode($detailsArr),
                'product_zysx' => $param['product_zysx'],
                'product_face' => $param['product_face'],
                'product_money' => $param['product_money'],
                'collection_id' => $param['collection_id'],
                'product_cover' => $param['cover_src'],
                'product_time' => time(),
                'product_type' => $param['product_type'],
                'product_times' => !empty($param['product_times']) ? $param['product_times'] : null,
                'product_share_index' => !empty($param['product_share_index']) ? 2 : 1,
                'product_collection_share' => !empty($param['product_collection_share']) ? 2 : 1,
                'product_status' => !empty($param['product_status']) ? 1 : 2,
                'product_start_time' => !empty($param['product_start_time']) ? strtotime($param['product_start_time']) : null,
                'product_end_time' => !empty($param['product_end_time']) ? strtotime($param['product_end_time']) : null,
            ];
            $ProductModel = ProductModel::create($productData);
            return $ProductModel ? json_encode([200, '添加成功']) : json_encode([400, '添加失败']);
        }
        $product_category = Category::where('category_fid', 0)->order('category_group_sort,category_sort')->field('category_id,category_name')->select();
        $collection = Collection::where([])->select();
        $config = Config::get('config');
        return $this->fetch('', [
            'product_category' => $product_category,
            'collection' => $collection,
            'face' => $config['face'],
            'product_type' => $config['product_type'],
            'type' => $this->product_type,
        ]);
    }


    /**
     * 修改产品排序
     */
    public function editsort()
    {
        $param = input('param.');
        $ProductModel = new ProductModel();
        $result = $ProductModel->save(
            [
                'product_sort' => $param['value']
            ], [
                'product_id' => $param['id']
            ]
        );
        return $result ? json_encode([200, '修改成功！']) : json_encode([400, '修改失败！']);
    }

    /**
     *Banner排序
     */
    public function bannersort()
    {
        $res = ProductBanner::update(['sort' => input('param.sort'), 'id' => input('param.id')]);
        return $res;
    }

    /**
     * 产品修改
     */
    public function edit1()
    {
        if ($this->request->isPost()) {
            $param = $this->request->param()['data'];
            $detailsArr = $this->request->param()['details'];
            $qny = new Qiniuyun();
            $product = new ProductModel();
            $res = $product->save([
                'product_name' => $param['product_name'],
                'product_category' => $param['product_category'],
                'product_categorys' => $param['product_categorys'],
                'vip' => !empty($param['vip']) ? $param['vip'] : null,
//                'product_category_ids' => $param['categorys'],
                'cover_introduce' => $param['cover_introduce'],
                'product_introduce' => htmlspecialchars_decode($detailsArr),
                'product_zysx' => $param['product_zysx'],
                'product_money' => $param['product_money'],
                'product_video_src' => $param['product_video_src'],
                'teacher_id' => $param['teacher_id'],
                'product_cover' => $param['cover_src'],
                //视频帧截图
//                'product_video_vframe' => $qny->key($param['product_video_src'], 2),
                //获取视频时长
                'product_times' => $qny->key($param['product_video_src'], 1),
                'taoc_id' => $param['producttaoc'] ? $param['producttaoc'] : null,
//                'product_time' => time(),
            ], [
                    'product_id' => $param['product_id']
                ]
            );
            return $msg = $res ? json_encode([200, '修改成功!']) : json_encode([400, '修改失败']);
        }
        $data = ProductModel::get(input('param.id'));
        $product_category = Category::where('category_fid', 0)->order('category_group_sort,category_sort')->field('category_id,category_name')->select();
        $product_categorys = Category::where('category_id', $data['product_categorys'])->order('category_group_sort,category_sort')->field('category_id,category_name')->select();
        $producttaoc = ProductTaoc::where([])->select();
        $category = ['0' => '热门课程', '1' => '最新课程', '2' => '推荐课程'];
        $categorys = ['0' => '文章', '1' => '理论', '2' => '咨询'];
        $config = Config::get('admin');
        //主讲老师
        $teacher = Collection::where([])->select();
//        dump($product_categorys);
        $fxs = Config::get('miniapp')['fxs'];
        return $this->fetch('', [
            'data' => $data,
            'product_category' => $product_category,
            'product_categorys' => $product_categorys,
            'producttaoc' => $producttaoc,
            'category' => $category,
            'categorys' => $categorys,
            'product_id' => input('param.id'),
            'collection' => $teacher,
            'fxs' => $fxs
        ]);
    }

    public function del()
    {
        $id = input('param.id');
        $product_face = ProductModel::get($id);
        $result = ProductModel::destroy($id);
        return $msg = $result ? '删除成功' : '删除失败';
    }

    public function delall()
    {
        $id = input('param.id/a');
        if (empty($id)) return '请选中后操作！';
        $idArr = implode(',', $id);
        $result = ProductModel::destroy($idArr);
        return $msg = $result ? json_encode([200, '删除成功']) : json_encode([400, '删除失败']);
    }

    /**
     * 修改产品状态
     */
    public function editstatus()
    {
        $param = input('param.');
        $ProductModel = new ProductModel();
        $result = $ProductModel->save(
            [
                'product_status' => $param['value']
            ], [
                'product_id' => $param['id']
            ]
        );
        return $result ? json_encode([200, '修改成功！']) : json_encode([400, '修改失败！']);
    }

    /**
     * 联动获取下级分类
     */
    public function getCate()
    {
        $fid = input('param.fid');
        $data = Category::where('category_fid', $fid)->order('category_group_sort,category_fid,category_sort')->field('category_id,category_name')->select();
        $this->result($data, 200, '获取子分类');
    }

    /**
     * 图片上传
     */
    public function SynUpload()
    {
        $file = request()->file('file');
        if (!$file) {
            return $this->fetch();
        }
        $path = 'uploads/productCover';
//        $path=ROOT_PATH.'extend/wxpay/cert';
        $info = $file->move($path);
        $resImageInfo = $path . '/' . $info->getSaveName();
        $image = Image::open($resImageInfo);
        $image->thumb(500, 500)->save($resImageInfo);
        if ($info) {
            return $this->result($resImageInfo, 200, '成功');
        } else {
            return $this->result($file->getError(), 400, '失败');
        }
    }

    /**
     * wangEditor 上传图片
     */
    public function imageUpload()
    {
        // 获取表单上传文件
        $files = request()->file('file');
        $path = 'uploads/productImg';
        $url = [];
        foreach ($files as $file) {
            $info = $file->move($path);
            $resImageInfo = $path . '/' . $info->getSaveName();
            $image = Image::open($resImageInfo);
            $image->thumb(1080, 1080)->save($resImageInfo);
            if ($info) {
                $url[] = getHttpHost() . '/' . $resImageInfo;
            }
        }
        $result = [
            'errno' => 0,
            'data' => $url,
        ];
        echo json_encode($result);
    }


}