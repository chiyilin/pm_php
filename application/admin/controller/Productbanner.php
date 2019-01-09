<?php

namespace app\admin\controller;

use think\Config;
use app\common\model\ProductBanner as ProductBannerModel;

class Productbanner extends Auth
{
    public $product_id;

    public function _initialize()
    {
        parent::_initialize();
        $this->product_id = input('param.id');
    }

    /**
     * Banner 首页
     */
    public function index()
    {
        $config = Config::get('admin');
        return $this->fetch('', [
            'data' => ProductBannerModel::where('product_id', $this->product_id)->order('sort')->paginate($config['paginate']),
            'product_id' => $this->product_id
        ]);
    }

    /**
     * Banner 上传（异步）
     */
    public function SynUpload()
    {
        $file = request()->file('file');
        if (!$file) {
            return $this->fetch('', ['product_id' => $this->product_id]);
        }
        $path = 'uploads/productBanner/';
        $info = $file->move($path);
        if ($info) {
            $Banner = new ProductBannerModel();
            $Banner->data([
                'url' => $path . $info->getSaveName(),
                'product_id' => input('param.id'),
                'add_time' => time(),
            ]);
            if ($Banner->save()) {
                return $this->result($info->getSaveName(), 200, '成功');
            }
        } else {
            return $this->result($file->getError(), 400, '失败');
        }
    }

    /**
     * 修改banner状态
     */
    public function editstatus()
    {
        $param = input('param.');
        $ProductBannerModel = new ProductBannerModel();
        $result = $ProductBannerModel->save(
            [
                'is_show' => $param['value']
            ], [
                'id' => $param['id']
            ]
        );
        return $result ? json_encode([200, '修改成功！']) : json_encode([400, '修改失败！']);
    }

    /**
     * 修改banner排序
     */
    public function editsort()
    {
        $param = input('param.');
        $ProductBannerModel = new ProductBannerModel();
        $result = $ProductBannerModel->save(
            [
                'sort' => $param['value']
            ], [
                'id' => $param['id']
            ]
        );
        return $result ? json_encode([200, '修改成功！']) : json_encode([400, '修改失败！']);
    }

    //删除
    public function del()
    {
        $id = input('param.id');
        $Banner = ProductBannerModel::get($id);
        $url = ROOT_PATH . $Banner->url;
        if (file_exists($url)) {
            unlink($url);
            clearstatcache();
        }
        $result = ProductBannerModel::destroy($id);
        return $msg = $result ? '删除成功' : '删除失败';
    }

    //多选删除
    public function delall()
    {
        $id = input('param.ids/a');
        if (empty($id)) return '请选中后操作！';
        $idArr = implode(',', $id);
        $bannerArr = ProductBannerModel::where('id', 'in', $idArr)->field('url')->select();
        foreach ($bannerArr as $key => $value) {
            $path = ROOT_PATH . $value['url'];
            if (file_exists($path)) {
                unlink($path);
                clearstatcache();
            }
        }
        $result = ProductBannerModel::destroy($idArr);
        return $msg = $result ? json_encode([200, '删除成功']) : json_encode([400, '删除失败']);
    }
}