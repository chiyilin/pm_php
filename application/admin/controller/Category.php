<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/8/27
 * Time: 12:45
 */

namespace app\admin\controller;

use app\common\model\Category as CategoryModel;

class Category extends Auth
{
    /**
     * 分类首页
     */
    public function index()
    {
        $oneCate = CategoryModel::where('category_fid', 0)->order('category_sort desc,category_time desc')->select()->toArray();
        foreach ($oneCate as $key => $value) {
            $data[] = $value;
            $oneCate[$key]['_child'] = CategoryModel::where('category_fid', $value['category_id'])->order('category_sort desc,category_time desc')->select()->toArray();
            if (!empty($oneCate[$key]['_child'])) {
                foreach ($oneCate[$key]['_child'] as $k => $v) {
                    $data[] = $v;
                    $oneCate[$key]['_child'][$k]['_child'] = CategoryModel::where('category_fid', $v['category_id'])->order('category_sort desc,category_time desc')->select()->toArray();
                    foreach ($oneCate[$key]['_child'][$k]['_child'] as $kk => $vv) {
                        $data[] = $vv;
                    }
                }
            }
        }
//        $data = CategoryModel::order('category_group_sort,category_fid')->Paginate(100, false, ['query' => request()->param()]);
        return $this->fetch('', [
            'data' => $data,
        ]);
    }

    //修改分类排序
    public function editsort()
    {
        $param = input('param.');
        $Category = new CategoryModel();
        $result = $Category->save(
            [
                'category_sort' => $param['value']
            ], [
                'category_id' => $param['id']
            ]
        );
        return $result ? json_encode([200, '修改成功！']) : json_encode([400, '修改失败！']);
    }

    //修改分类状态
    public function editstatus()
    {
        $param = input('param.');
        $Category = new CategoryModel();
        $result = $Category->save(
            [
                'category_status' => $param['value']
            ], [
                'category_id' => $param['id']
            ]
        );
        return $result ? json_encode([200, '修改成功！']) : json_encode([400, '修改失败！']);
    }

    //删除
    public function del()
    {
        $result = CategoryModel::destroy(input('param.id'));
        return $msg = $result ? '删除成功' : '删除失败';
    }

    //多选删除
    public function delall()
    {
        $id = input('param.id/a');
        if (empty($id)) return '请选中后操作！';

        $idArr = implode(',', $id);
        $result = CategoryModel::destroy($idArr);
        return $msg = $result ? json_encode([200, '删除成功']) : json_encode([400, '删除失败']);
    }

    //新增分类
    public function add()
    {
        if (!$this->request->isPost()) {
            return json_encode([400, '请求失败']);
        }
        $param = $this->request->param()['data'];
        $countNow = CategoryModel::where(['category_name' => $param['category_name']])->count();
        $countNow ? $this->error('分类已存在！') : null;
        $maxGroupSort = CategoryModel::max('category_group_sort') + 1;
        $category = new CategoryModel();
        $res = $category->save([
            'category_name' => $param['category_name'],
            'category_group_sort' => $maxGroupSort,
            'category_time' => time(),
        ]);
        return $msg = $res ? json_encode([200, '添加成功']) : json_encode([400, '添加失败']);
    }

    /*
     * 指定父类添加分类
     * */
    public function addmaster()
    {
        if ($this->request->isPost()) {
            $param = $this->request->param()['data'];
//            echo $param['category_status'];die();
            $cate = new CategoryModel();
            $fidInfo = CategoryModel::find($param['category_fid']);

            $result = $cate->save([
                'category_name' => $param['category_name'],
                'category_fid' => $param['category_fid'],
                'category_level' => $fidInfo['category_level'] + 1,
                'category_group_sort' => $param['category_group_sort'],
                'category_status' => !empty($param['category_status']) ? 1 : 2,
                'category_sort' => $param['category_sort'],
                'category_time' => time(),
            ]);
            return $msg = $result ? json_encode([200, '添加成功']) : json_encode([400, '添加失败']);
        }
        $data = CategoryModel::get(input('param.fid'));
        if (!$data) {
            return;
        }
        $Category = CategoryModel::get(input('param.fid'));
        return $this->fetch('', [
            'category' => $Category
        ]);
    }

    public function edit()
    {
        if ($this->request->isPost()) {
            $param = $this->request->param()['data'];
//            echo $param['category_status'];die();
            $cate = new CategoryModel();
            $result = $cate->save([
                'category_name' => $param['category_name'],
//                'category_fid' => $param['category_fid'],
                'category_status' => !empty($param['category_status']) ? 1 : 2,
                'category_sort' => $param['category_sort'],
            ], [
                'category_id' => $param['category_id'],
            ]);
            return $msg = $result ? json_encode([200, '修改成功']) : json_encode([400, '修改失败']);
        }
        $data = CategoryModel::get(input('param.id'));
        if (!$data) {
            return;
        }
        $Category = CategoryModel::order('category_group_sort,category_fid,category_sort')->select();
        // dump($Category->toArray());
        return $this->fetch('', [
            'data' => $data,
            'category' => $Category
        ]);
    }

}